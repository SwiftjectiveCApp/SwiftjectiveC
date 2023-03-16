import SwiftUI
import Authentication

public final class AppController: NSObject, GitHubSessionListener, AuthenticationDelegate, ObservableObject {
    private let sessionManager = GitHubSessionManager()
    @Published public var shouldShowHomeView = false

    public override init() {
        super.init()
        sessionManager?.listener = self
    }

    public func buildAuthenticationView() -> some View {
        AuthenticationView(delegate: self)
    }

    public func shouldLogout() {
        sessionManager?.logout()
    }

    // MARK: - GitHubSessionListener

    public func didFocus() {
        DispatchQueue.main.async {
            self.shouldShowHomeView = true
        }
    }

    // MARK: - AuthenticationDelegate

    @MainActor
    public func finishLogin(token: String, authMethod: AuthMethod, username: String) {
        let userSession = GitHubUserSession(
            token: token,
            authMethod: authMethod.rawValue,
            username: username
        )
        sessionManager?.focus(userSession)
    }
}
