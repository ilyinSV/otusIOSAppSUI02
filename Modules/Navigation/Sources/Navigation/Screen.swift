
import Foundation
import SwiftUI

public struct Screen: Identifiable, Equatable {
    
    public let id = UUID().uuidString
    public let view: AnyView
    
    public static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}
