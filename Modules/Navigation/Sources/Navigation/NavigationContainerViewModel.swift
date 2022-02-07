
import Foundation
import SwiftUI

public class NavigationContainerViewModel : ObservableObject {
    
    @Published var currentScreen: Screen?
    public var navigationType: NavigationType = .push
    
    private var screenStack = NavigationStack() {
        didSet {
            self.currentScreen = screenStack.top()
        }
    }
    
    public func push(view: AnyView) {
        self.navigationType = .push
        let screen = Screen(view: view)
        screenStack.push(screen)
    }
    
    public func pop() {
        self.navigationType = .pop
        screenStack.pop()
    }
    
    public func popToRoot() {
        self.navigationType = .popToRoot
        screenStack.popToRoot()
    }
}
