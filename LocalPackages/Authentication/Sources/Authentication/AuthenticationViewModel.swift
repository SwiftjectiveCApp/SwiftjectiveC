import Networking
import Foundation

final class AuthenticationViewModel: ObservableObject {
    private let controller: GitHubControlling

    init(controller: GitHubControlling = GitHubController()) {
        self.controller = controller
    }

    func loginWithToken() async {

    }

}
