import Foundation

public struct GitHubError: LocalizedError, Codable, Equatable {
    /// A message that describes why the error did occur.
    public let message: String

    public var errorDescription: String? { message }
}
