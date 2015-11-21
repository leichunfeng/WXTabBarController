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

#define WXWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define WXHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    WXTabBarController *tabBarController = [[WXTabBarController alloc] init];
    
    ViewController *mainframeViewController = [[ViewController alloc] init];
    mainframeViewController.view.backgroundColor = [UIColor redColor];

    UIImage *mainframeImage = [[UIImage imageNamed:@"tabbar_mainframe"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *mainframeHLImage = [[UIImage imageNamed:@"tabbar_mainframeHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainframeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"微信"
                                                                       image:mainframeImage
                                                               selectedImage:mainframeHLImage];

    ViewController *contactsViewController = [[ViewController alloc] init];
    contactsViewController.view.backgroundColor = [UIColor orangeColor];

    UIImage *contactsImage = [[UIImage imageNamed:@"tabbar_contacts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *contactsHLImage = [[UIImage imageNamed:@"tabbar_contactsHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    contactsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通讯录"
                                                                      image:contactsImage
                                                              selectedImage:contactsHLImage];

    ViewController *discoverViewController = [[ViewController alloc] init];
    discoverViewController.view.backgroundColor = [UIColor yellowColor];

    UIImage *discoverImage = [[UIImage imageNamed:@"tabbar_discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *discoverHLImage = [[UIImage imageNamed:@"tabbar_discoverHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoverViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
                                                                      image:discoverImage
                                                              selectedImage:discoverHLImage];

    ViewController *meViewController = [[ViewController alloc] init];
    meViewController.view.backgroundColor = [UIColor greenColor];

    UIImage *meImage = [[UIImage imageNamed:@"tabbar_contacts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *meHLImage = [[UIImage imageNamed:@"tabbar_contactsHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我"
                                                                image:meImage
                                                        selectedImage:meHLImage];

    tabBarController.viewControllers = @[ mainframeViewController, contactsViewController, discoverViewController, meViewController ];
    tabBarController.tabBar.tintColor = HexRGB(0x1AB20A);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
