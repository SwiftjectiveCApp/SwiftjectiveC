#import "ProfileViewController.h"
@import Models;
@import Networking;

@interface ProfileViewController ()

@property (nonatomic, strong) GitHubController *controller;

@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *followersLabel;
@property (nonatomic, strong) UILabel *followingLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Profile";
    self.controller = [[GitHubController alloc] init];

    self.usernameLabel = [[UILabel alloc] init];
    self.usernameLabel.textAlignment = NSTextAlignmentLeft;
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.followersLabel = [[UILabel alloc] init];
    self.followersLabel.textAlignment = NSTextAlignmentLeft;
    self.followersLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.followingLabel = [[UILabel alloc] init];
    self.followingLabel.textAlignment = NSTextAlignmentLeft;
    self.followingLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.usernameLabel];
    [self.view addSubview:self.followersLabel];
    [self.view addSubview:self.followingLabel];

    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints: @[
        [self.usernameLabel.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:16.0],
        [self.usernameLabel.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor],
        [self.usernameLabel.topAnchor constraintEqualToAnchor:guide.topAnchor constant:16.0],

        [self.followersLabel.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor],
        [self.followersLabel.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor],
        [self.followersLabel.topAnchor constraintEqualToAnchor:self.usernameLabel.bottomAnchor constant:16.0],

        [self.followingLabel.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor],
        [self.followingLabel.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor],
        [self.followingLabel.topAnchor constraintEqualToAnchor:self.followersLabel.bottomAnchor constant:16.0]
    ]];

    [self fetchUser];
}

- (void) fetchUser {
    [self.controller userWithCompletion:^(User * _Nullable user, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else if (user) {
                self.usernameLabel.text = user.name;
                self.followingLabel.text = [user.following stringValue];
                self.followersLabel.text = [user.followers stringValue];
            }
        });
    }];
}

@end
