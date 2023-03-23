import Foundation

@objcMembers public class User: NSObject, NSCoding, Codable {
    public var htmlUrl: String?
    public var name: String?
    public var login: String?
    public var followers: NSNumber?
    public var following: NSNumber?

    public init(htmlUrl: String?, name: String?, login: String?, followers: NSNumber?, following: NSNumber?) {
        self.htmlUrl = htmlUrl
        self.name = name
        self.login = login
        self.followers = followers
        self.following = following
    }

    required public init?(coder aDecoder: NSCoder) {
        self.htmlUrl = aDecoder.decodeObject(forKey: "htmlUrl") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.login = aDecoder.decodeObject(forKey: "login") as? String
        self.followers = aDecoder.decodeObject(forKey: "followers") as? NSNumber
        self.following = aDecoder.decodeObject(forKey: "following") as? NSNumber
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(htmlUrl, forKey: "htmlUrl")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(login, forKey: "login")
        aCoder.encode(followers, forKey: "followers")
        aCoder.encode(following, forKey: "following")
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.htmlUrl, forKey: .htmlUrl)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.login, forKey: .login)
    }

    enum CodingKeys: String, CodingKey {
        case htmlUrl = "html_url"
        case name
        case login
        case followers
        case following
    }
}
