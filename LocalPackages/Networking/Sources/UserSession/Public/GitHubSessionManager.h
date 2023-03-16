#import <Foundation/Foundation.h>
#import "GitHubUserSession.h"
#import "GitHubSessionListener.h"

@interface GitHubSessionManager : NSObject

@property (nonatomic, weak) id<GitHubSessionListener> listener;

- (instancetype)init;

- (GitHubUserSession *)focusedUserSession;
- (void)focus:(GitHubUserSession *)userSession;
- (NSArray<GitHubUserSession *> *)userSessions;
- (void)logout;

@end
