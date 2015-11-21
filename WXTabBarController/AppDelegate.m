//
//  AppDelegate.m
//  WXTabBarController
//
//  Created by leichunfeng on 15/11/20.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "WXTabBarController.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) WXTabBarController *tabBarController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UINavigationController *)navigationController {
    if (_navigationController == nil) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.tabBarController];
        navigationController.navigationBar.tintColor = [UIColor colorWithRed:26 / 255.0 green:178 / 255.0 blue:10 / 255.0 alpha:1];
        _navigationController = navigationController;
    }
    return _navigationController;
}

- (WXTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        WXTabBarController *tabBarController = [[WXTabBarController alloc] init];
        
        ViewController *mainframeViewController = ({
            ViewController *mainframeViewController = [[ViewController alloc] init];
            
            UIImage *mainframeImage   = [[UIImage imageNamed:@"tabbar_mainframe"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage *mainframeHLImage = [[UIImage imageNamed:@"tabbar_mainframeHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            mainframeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"微信" image:mainframeImage selectedImage:mainframeHLImage];
            mainframeViewController.view.backgroundColor = [UIColor redColor];
            
            mainframeViewController;
        });
        
        ViewController *contactsViewController = ({
            ViewController *contactsViewController = [[ViewController alloc] init];
            
            UIImage *contactsImage   = [[UIImage imageNamed:@"tabbar_contacts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage *contactsHLImage = [[UIImage imageNamed:@"tabbar_contactsHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            contactsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:contactsImage selectedImage:contactsHLImage];
            contactsViewController.view.backgroundColor = [UIColor orangeColor];
            
            contactsViewController;
        });
        
        ViewController *discoverViewController = ({
            ViewController *discoverViewController = [[ViewController alloc] init];
            
            UIImage *discoverImage   = [[UIImage imageNamed:@"tabbar_discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage *discoverHLImage = [[UIImage imageNamed:@"tabbar_discoverHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            discoverViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:discoverImage selectedImage:discoverHLImage];
            discoverViewController.view.backgroundColor = [UIColor yellowColor];
            
            discoverViewController;
        });
        
        ViewController *meViewController = ({
            ViewController *meViewController = [[ViewController alloc] init];
            
            UIImage *meImage   = [[UIImage imageNamed:@"tabbar_contacts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage *meHLImage = [[UIImage imageNamed:@"tabbar_contactsHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            meViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:meImage selectedImage:meHLImage];
            meViewController.view.backgroundColor = [UIColor greenColor];
            
            meViewController;
        });
        
        tabBarController.title = @"微信";
        tabBarController.viewControllers = @[ mainframeViewController, contactsViewController, discoverViewController, meViewController ];
        tabBarController.tabBar.tintColor = [UIColor colorWithRed:26 / 255.0 green:178 / 255.0 blue:10 / 255.0 alpha:1];

        tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"]
                                                                                              style:UIBarButtonItemStylePlain
                                                                                             target:self
                                                                                             action:@selector(didClickAddButton:)];
        
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (void)didClickAddButton:(id)sender {
    ViewController *viewController = [[ViewController alloc] init];
    
    viewController.title = @"添加";
    viewController.view.backgroundColor = [UIColor purpleColor];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
