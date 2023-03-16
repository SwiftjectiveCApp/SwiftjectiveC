import Networkable
import Models
import Foundation
@_exported import UserSession

public protocol GitHubControlling {
    /// Login with token.
    func verifyPersonalAccessTokenRequest(token: String) async throws -> User

    /// Get repositories information.
    func repos() async throws -> [Repository]
}

public final class GitHubController: GitHubControlling {
    private let session: NetworkableSession

    // MARK: - Init

    public init(
        session: NetworkableSession = NetworkSession.github
    ) {
        self.session = session
    }

    // MARK: - RemoteGitHubRepository

    public func verifyPersonalAccessTokenRequest(token: String) async throws -> User {
        try await parseData(from: .user(token: token))
    }

    public func repos() async throws -> [Repository] {
        try await parseData(from: .repos)
    }

    // MARK: - Helpers

    private func parseData<T: Codable>(from request: GitHubController.API) async throws -> T {
        try await session.data(for: request, decoder: JSONDecoder())
    }
}

extension GitHubController {
    enum API: Request {
        case user(token: String)
        case repos

        // MARK: - Request

        var headers: [String : String]? {
            switch self {
            case .repos:
                let sessionManager: GitHubSessionManager = .init()
                guard let focusedUserSession = sessionManager.focusedUserSession() else { return [:] }
                let authorizationHeader = focusedUserSession.authorizationHeader()
                return [
                    "Authorization": authorizationHeader,
                    "Accept": "application/vnd.github+json"
                ]
            case let .user(token):
                return ["Authorization": "token \(token)"]
            }

        }

        var url: String {
            switch self {
            case .user:
                return "https://api.github.com/user"
            case .repos:
                return "https://api.github.com/user/repos?sort=updated"
            }
        }

        var method: Networkable.Method {
            .get
        }

        func body() throws -> Data? {
            nil
        }
    }
}
