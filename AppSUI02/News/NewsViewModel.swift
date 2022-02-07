
import Foundation
import Networking

final class NewsViewModel: ObservableObject {

    @Published var listViewTypeChoice: Int = 0 {
        didSet {
            loadFirstPageIfNeeded()
        }
    }
    
    @Published private(set) var articlesGroups = [
        Articles(withTopic: "Apple VR"),
        Articles(withTopic: "Garmin Fenix"),
        Articles(withTopic: "Wahoo"),
    ]
    
    @Published var isPageLoading: Bool = false
    
    init() {
        loadFirstPageIfNeeded()
    }
    
    func loadFirstPageIfNeeded() {
        if self.articlesGroups[listViewTypeChoice].articlesArray.isEmpty {
            loadNextPage()
        }
    }
    
    func loadNextPage() {
        let news = self.articlesGroups[listViewTypeChoice]
        
        guard isPageLoading == false && news.totalResults > news.articlesArray.count else {
            print("Nothing to load \(news.articlesArray.count)/\(news.totalResults)")
            return
        }
        
        self.isPageLoading = true
        news.loadNext {
            self.isPageLoading = false
        }
    }
}

class Articles {
    
    let fromDateString = "2022-02-01"
    let apiKeyString = "76503060475b4dfdb2cf24d23cbcdf66"
    
    var topic: String
    var articlesArray: [Article] = []
    var totalResults: Int = Int.max
    var page: Int = 0
    
    init(withTopic topic: String) {
        self.topic = topic
    }
    
    func loadNext(complition: @escaping () -> Void) {
        self.page += 1
        print("do new request \(self.topic) + page:\(self.page)")
        DispatchQueue.global(qos: .background).async {
            ArticlesAPI.everythingGet(q: self.topic,
                                      from: self.fromDateString,
                                      sortBy: "publishedAt",
                                      language: "en",
                                      apiKey: self.apiKeyString,
                                      page: self.page) { list, error in
                self.totalResults = list?.totalResults ?? Int.max
                self.articlesArray.append(contentsOf: list?.articles ?? [])
                complition()
            }
        }
    }
}

extension Article: Identifiable {
    public var id: String {
        url
    }
}

extension RandomAccessCollection where Self.Element: Identifiable {
    
    public func isLast(_ item: Element) -> Bool {
        guard isEmpty == false else {
            return false
        }
        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        return distance(from: itemIndex, to: endIndex) == 1
    }
    
}
