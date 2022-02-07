
import SwiftUI
import Navigation

struct DashboardScreen: View {
    
    @EnvironmentObject var routerModel: NavigationContainerViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                self.routerModel.push(view: NewsScreen().toAnyView())
            }) {
                HStack {
                    Image(systemName: "newspaper")
                    Text("News")
                }
                .padding(10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(lineWidth: 2.0)
                )
            }
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreen()
    }
}
