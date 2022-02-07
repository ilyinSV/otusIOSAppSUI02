
import SwiftUI
import Navigation
import SafariServices

struct NewsItemScreen: View {
    
    var url: String

    var body: some View {
        SafariView(url: URL(string: self.url)!)
    }
}

public struct SafariView: View {
    
    @EnvironmentObject var routerModel: NavigationContainerViewModel
    
    var url: URL?
    var entersReaderIfAvailable: Bool = false

    public var body: some View {
        SafariViewRepresentable(routerModel: routerModel,
                                url: url!,
                                enterReader: entersReaderIfAvailable)
            .navigationBarHidden(true)
            .ignoresSafeArea()
    }
}

struct SafariViewRepresentable: UIViewControllerRepresentable {

    var routerModel: NavigationContainerViewModel
    var url: URL?
    let enterReader: Bool

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = enterReader

        let vc = SFSafariViewController(url: url!, configuration: config)
        vc.delegate = context.coordinator

        return vc
    }

    func updateUIViewController(_ controller: SFSafariViewController,
                                context: UIViewControllerRepresentableContext<SafariViewRepresentable>) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, router: routerModel)
    }
}

extension SafariViewRepresentable {

    final class Coordinator: NSObject, SFSafariViewControllerDelegate {
        var parent: SafariViewRepresentable
        var routerModel: NavigationContainerViewModel
        
        init(_ parent: SafariViewRepresentable, router: NavigationContainerViewModel) {
            self.parent = parent
            self.routerModel = router
        }

        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            self.parent.url = nil
            self.routerModel.pop()
        }
    }
}

struct NewsItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsItemScreen(url: "")
    }
}
