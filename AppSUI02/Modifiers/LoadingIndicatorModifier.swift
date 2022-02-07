
import SwiftUI

extension View {
    func showActivityIdicator(_ value: Bool) -> some View {
        ModifiedContent(content: self,
                        modifier: LoadingIndicatorModifier(isLoading: value))
    }
}

struct LoadingIndicatorModifier: ViewModifier {
    
    var isLoading: Bool
    
    func body(content: Content) -> some View {
        if isLoading {
            withLoading(content: content)
        } else {
            withoutLoading(content: content)
        }
    }
    
    func withoutLoading(content: Content) -> some View {
        content
    }
    
    func withLoading(content: Content) -> some View {
        print("withLoading")
        return VStack {
            content
            Divider()
            HStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Spacer()
            }
        }
    }
}
