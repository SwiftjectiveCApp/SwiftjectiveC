import Foundation
import Networking

public protocol AuthenticationDelegate: AnyObject {
    func finishLogin(token: String, authMethod: AuthMethod, username: String)
}

final class AuthenticationViewModel: ObservableObject {
    private let controller: GitHubControlling
    weak var delegate: AuthenticationDelegate?

    init(controller: GitHubControlling = GitHubController()) {
        self.controller = controller
    }

    func loginWithToken(_ token: String) async {
        do {
            let user = try await controller.verifyPersonalAccessTokenRequest(token: token)
            self.delegate?.finishLogin(
                token: token,
                authMethod: .PAT,
                username: user.name ?? ""
            )
        } catch {
            print("Failed to login with token \(error)")
        }
    }
}
