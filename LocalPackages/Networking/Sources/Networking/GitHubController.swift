import Networkable
import Models
import Foundation
@_exported import UserSession

public protocol GitHubControlling {
    /// Login with token.
    func verifyPersonalAccessTokenRequest(token: String) async throws -> User

    /// Get repositories information.
    func repos() async throws -> [Repository]

    /// Get the user information.
    func user(completion: @escaping (User?, Error?) -> Void)
}

@objc
public final class GitHubController: NSObject, GitHubControlling {
    private let session: NetworkableSession

    // MARK: - Init

    public init(
        session: NetworkableSession = NetworkSession.github
    ) {
        self.session = session
    }

    public override init() {
        self.session = NetworkSession.github
    }

    // MARK: - RemoteGitHubRepository

    public func verifyPersonalAccessTokenRequest(token: String) async throws -> User {
        try await parseData(from: .userFromToken(token))
    }

    public func repos() async throws -> [Repository] {
        try await parseData(from: .repos)
    }

    @objc public func user(completion: @escaping (User?, Error?) -> Void) {
        session.dataTask(
            for: API.user,
            resultQueue: nil,
            decoder: JSONDecoder()
        ) { (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                completion(user, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    // MARK: - Helpers

    private func parseData<T: Codable>(from request: GitHubController.API) async throws -> T {
        try await session.data(for: request, decoder: JSONDecoder())
    }
}

extension GitHubController {
    enum API: Request {
        case userFromToken(_ token: String)
        case repos
        case user

        // MARK: - Request

        var headers: [String : String]? {
            switch self {
            case .repos, .user:
                let sessionManager: GitHubSessionManager = .init()
                guard let focusedUserSession = sessionManager.focusedUserSession() else { return [:] }
                let authorizationHeader = focusedUserSession.authorizationHeader()
                return [
                    "Authorization": authorizationHeader,
                    "Accept": "application/vnd.github+json"
                ]
            case let .userFromToken(token):
                return ["Authorization": "token \(token)"]
            }

        }

        var url: String {
            switch self {
            case .user, .userFromToken:
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
