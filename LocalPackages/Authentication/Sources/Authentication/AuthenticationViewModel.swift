import Foundation
import Networking

final class AuthenticationViewModel: ObservableObject {
    private let controller: GitHubControlling

    init(controller: GitHubControlling = GitHubController()) {
        self.controller = controller
    }

    func loginWithToken(_ token: String) async {
        do {
            try await controller.loginWithToken()
        } catch {}
    }

}
