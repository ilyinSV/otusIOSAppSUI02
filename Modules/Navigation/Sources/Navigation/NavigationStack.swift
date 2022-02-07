
import Foundation

public struct NavigationStack {
    
    private var screens = [Screen]()
    
    public mutating func push(_ screen: Screen) {
        self.screens.append(screen)
    }
    
    public mutating func pop() {
        _ = self.screens.popLast()
    }
    
    public mutating func popToRoot() {
        self.screens.removeAll()
    }
    
    public func top() -> Screen? {
        self.screens.last
    }
}
