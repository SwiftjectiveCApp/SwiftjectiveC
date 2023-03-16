#import "GitHubSessionManager.h"

@implementation GitHubSessionManager {
    NSMutableOrderedSet<GitHubUserSession *> *_userSessions;
    NSUserDefaults *_defaults;
    NSString *_sessionKeys;
}

- (instancetype)init {
    if (self = [super init]) {
        _defaults = [[NSUserDefaults alloc] initWithSuiteName:@"space.khoale.gisthub"] ?: [NSUserDefaults standardUserDefaults];
        _sessionKeys = @"com.github.sessionmanager.shared.session";

        NSData *data = [_defaults objectForKey:_sessionKeys];
        NSOrderedSet<GitHubUserSession *> *session = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (data && session) {
            _userSessions = [NSMutableOrderedSet orderedSetWithOrderedSet:session];
        } else {
            _userSessions = [NSMutableOrderedSet orderedSet];
        }
    }
    return self;
}

- (GitHubUserSession *)focusedUserSession {
    return [_userSessions firstObject];
}

- (void)focus:(GitHubUserSession *)userSession {
    [_userSessions removeObject:userSession];
    [_userSessions insertObject:userSession atIndex:0];
    [self save];
    if (self.listener) {
        [self.listener didFocus];
    }
}

- (NSArray<GitHubUserSession *> *)userSessions {
    return [_userSessions array];
}

- (void)logout {
    [_userSessions removeAllObjects];
    [self save];
}

- (void)save {
    if (_userSessions.count > 0) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_userSessions];
        [_defaults setObject:data forKey:_sessionKeys];
    } else {
        [_defaults removeObjectForKey:_sessionKeys];
    }
}

@end
