#import "GitHubUserSession.h"

@implementation GitHubUserSession

- (instancetype)initWithToken:(NSString *)token authMethod:(NSInteger)authMethod username:(nullable NSString *)username {
    self = [super init];
    if (self) {
        _token = token;
        _authMethod = authMethod;
        _username = username;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _token = [decoder decodeObjectForKey:@"token"];
        _username = [decoder decodeObjectForKey:@"username"];
        NSInteger authMethodValue = [decoder decodeIntegerForKey:@"authMethod"];
        _authMethod = authMethodValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_token forKey:@"token"];
    [coder encodeObject:_username forKey:@"username"];
    [coder encodeInteger:_authMethod forKey:@"authMethod"];
}

- (NSString *)authorizationHeader {
    switch (_authMethod) {
        case OAUTH:
            return [NSString stringWithFormat:@"Bearer %@", _token];
        case PAT:
            return [NSString stringWithFormat:@"token %@", _token];
        default:
            return @"";
    }
}

@end
