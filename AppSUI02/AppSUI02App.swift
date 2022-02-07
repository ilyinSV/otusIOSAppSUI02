
import SwiftUI
import Navigation

@main
struct AppSUI02App: App {
    var body: some Scene {
        WindowGroup {
            NavigationContainerView(transition: Transition.custom(.slide),
                                    content: {
                DashboardScreen()
            })
        }
    }
}
