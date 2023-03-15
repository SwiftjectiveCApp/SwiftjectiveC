import Networkable
import Models
import Foundation

public protocol GitHubControlling {
    /// Login with token.
    func loginWithToken() async throws -> User

    /// Get the repository information.
    func repo(owner: String, repo: String) async throws -> Repository
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

    public func loginWithToken() async throws -> User {
        try await parseData(from: .loginWithToken)
    }

    public func repo(owner: String, repo: String) async throws -> Repository {
        try await parseData(from: .repo(owner: owner, repo: repo))
    }

    // MARK: - Helpers

    private func parseData<T: Codable>(from request: GitHubController.API) async throws -> T {
        try await session.data(for: request, decoder: JSONDecoder())
    }
}

extension GitHubController {
    enum API: Request {
        case loginWithToken
        case repo(owner: String, repo: String)

        // MARK: - Request

        var headers: [String : String]? {
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(UserDefaultManagement.accessToken)"
            ]
        }

        var url: String {
            switch self {
            case .loginWithToken:
                return buildURLString(fromPath: "/user")
            case let .repo(owner, repo):
                return buildURLString(fromPath: "/repos/\(owner)/\(repo)")
            }
        }

        private func buildURLString(fromPath path: String) -> String {
            if let hostname = UserDefaultManagement.hostname,
               let hostnameURL = URL(string: hostname),
               let url = URL(string: "/api/v3\(path)", relativeTo: hostnameURL) {
                return url.absoluteString
            }
            return path
        }

        var method: Networkable.Method {
            .get
        }

        func body() throws -> Data? {
            nil
        }
    }
}
