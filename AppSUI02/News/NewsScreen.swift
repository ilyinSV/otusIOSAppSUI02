
import SwiftUI
import Navigation
import Networking

struct NewsScreen: View {
    
    @EnvironmentObject var routerModel: NavigationContainerViewModel
    
    var body: some View {
        VStack {
            Button {
                self.routerModel.pop()
            } label: {
                Text("back").frame(height: 50)
            }
            ListView()
        }
    }
}

struct ListView: View {
    
    @StateObject var newsViewModel: NewsViewModel = .init()
    
    // Segment Control
    var listTypes = ["Apple", "Garmin", "Wahoo"]
    
    var body: some View {
        VStack {
            Picker("Lists", selection: $newsViewModel.listViewTypeChoice) {
                ForEach(0..<listTypes.count) { index in
                    Text(listTypes[index])
                        .tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            List {
                ForEach(newsViewModel.articlesGroups[newsViewModel.listViewTypeChoice].articlesArray) { article in
                    NewsArticleCell(article: article)
                        .showActivityIdicator(newsViewModel.isPageLoading && newsViewModel.articlesGroups[newsViewModel.listViewTypeChoice].articlesArray.isLast(article))
                        .onAppear {
                            if newsViewModel.articlesGroups[newsViewModel.listViewTypeChoice].articlesArray.isLast(article) {
                                newsViewModel.loadNextPage()
                            }
                        }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct NewsArticleCell: View {
    
    @EnvironmentObject var routerModel: NavigationContainerViewModel
    
    var article: Article

    var body: some View {
        Text(article.title ?? "")
            .onTapGesture {
                self.routerModel.push(view: NewsItemScreen(url: article.url).toAnyView())
            }
    }
    
}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
