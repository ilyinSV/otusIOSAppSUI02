
import SwiftUI

public enum Transition {
    case none
    case custom(AnyTransition)
}

public enum NavigationType {
    case pop
    case push
    case popToRoot
}

public struct NavigationContainerView<Content: View>: View {
    
    @StateObject var viewModel = NavigationContainerViewModel()
    
    private let content: Content
    private let animation: Animation = .easeOut(duration: 0.3)
    private let transition: (push: AnyTransition, pop: AnyTransition)
    
    public init(transition: Transition, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        
        switch transition {
        case .none:
            self.transition = (.identity, .identity)
        case .custom(let transition):
            self.transition = (transition, transition)
        }
    }
    
    public var body: some View {
        let isRoot = self.viewModel.currentScreen == nil
        return ZStack {
            if isRoot {
                self.content.environmentObject(self.viewModel)
                    .animation(self.animation)
                    .transition(self.viewModel.navigationType == .push
                                ? transition.push
                                : transition.pop)
            } else {
                self.viewModel.currentScreen?.view.environmentObject(self.viewModel)
                    .animation(self.animation)
                    .transition(self.viewModel.navigationType == .push
                                ? transition.push
                                : transition.pop)
            }
        }
    }
}
