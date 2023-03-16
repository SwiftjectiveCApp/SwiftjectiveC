#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GitHubUserSession : NSObject <NSCoding>

@property (nonatomic, strong, readonly) NSString *token;
@property (nonatomic, assign, readonly) NSInteger authMethod;
@property (nonatomic, strong, nullable, readonly) NSString *username;

typedef NS_ENUM(NSInteger, AuthMethod) {
    OAUTH,
    PAT
};

- (instancetype)initWithToken:(NSString *)token authMethod:(NSInteger)authMethod username:(nullable NSString *)username;

- (NSString *)authorizationHeader;

@end

NS_ASSUME_NONNULL_END
