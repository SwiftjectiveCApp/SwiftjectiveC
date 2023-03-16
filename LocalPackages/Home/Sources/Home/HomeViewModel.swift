import Combine
import Networking
import Models

@MainActor
final class HomeViewModel: ObservableObject {
    enum ContentState {
        case loading
        case content(_ model: [Repository])
        case error(error: String)
    }

    @Published var contentState: ContentState = .loading
    private let controller: GitHubControlling

    init(controller: GitHubControlling = GitHubController()) {
        self.controller = controller
    }

    func fetchRepos() async {
        do {
            let repos = try await controller.repos()
            contentState = .content(repos)
        } catch {
            contentState = .error(error: error.localizedDescription)
        }

    }
}
