//
//  WXTabBarController.m
//  WXTabBarController
//
//  Created by leichunfeng on 15/11/20.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "WXTabBarController.h"
#import "ViewController.h"

#define WXWidth  CGRectGetWidth(self.view.frame)
#define WXHeight CGRectGetHeight(self.view.frame)
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface WXTabBarController () <UIScrollViewDelegate>

@property (nonatomic, copy) NSArray<__kindof UIViewController *> *backingViewControllers;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微信";
    self.delegate = self;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    
    [self.view insertSubview:self.scrollView belowSubview:self.tabBar];
}

- (NSArray<UIViewController *> *)viewControllers {
    return nil;
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [self setViewControllers:viewControllers animated:NO];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers animated:(BOOL)animated {
    self.backingViewControllers = viewControllers;
}

- (void)setBackingViewControllers:(NSArray *)backingViewControllers {
    _backingViewControllers = backingViewControllers;
    [backingViewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(WXWidth * idx, 0, WXWidth, WXHeight);
        [self.scrollView addSubview:viewController.view];
    }];
    self.scrollView.contentSize = CGSizeMake(WXWidth * backingViewControllers.count, WXHeight);
}

- (UIView *)highlightImageViewInTabBarButton:(UIView *)tabBarButton {
    for (UIView *subview in tabBarButton.subviews) {
        if ([subview isMemberOfClass:[UIImageView class]]) {
            return subview;
        }
    }
    return nil;
}

- (UIView *)normalImageViewInTabBarButton:(UIView *)tabBarButton {
    for (UIView *subview in tabBarButton.subviews) {
        if ([subview isMemberOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            return subview;
        }
    }
    return nil;
}

- (UIView *)highlightLabelInTabBarButton:(UIView *)tabBarButton {
    for (UIView *subview in tabBarButton.subviews) {
        if ([subview isMemberOfClass:[UILabel class]]) {
            return subview;
        }
    }
    return nil;
}

- (UIView *)normalLabelInTabBarButton:(UIView *)tabBarButton {
    for (UIView *subview in tabBarButton.subviews) {
        if ([subview isMemberOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
            return subview;
        }
    }
    return nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self tabBarButtons] enumerateObjectsUsingBlock:^(UIView *tabBarButton, NSUInteger idx, BOOL *stop) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:tabBarButton.subviews.firstObject.frame];
            
            imageView.image = self.backingViewControllers[idx].tabBarItem.selectedImage;
            [tabBarButton insertSubview:imageView atIndex:0];
            
            UILabel *label = [[UILabel alloc] initWithFrame:tabBarButton.subviews.lastObject.frame];
            label.textColor = self.tabBar.tintColor;
            label.font = [UIFont systemFontOfSize:10];
            label.text = self.backingViewControllers[idx].tabBarItem.title;
            [tabBarButton insertSubview:label atIndex:1];
        }];
        
        [[self tabBarButtons] enumerateObjectsUsingBlock:^(UIView *tabBarButton, NSUInteger idx, BOOL *stop) {
            if (idx == 0) {
                tabBarButton.subviews[0].alpha = 1;
                tabBarButton.subviews[2].alpha = 0;
                tabBarButton.subviews[1].alpha = 1;
                tabBarButton.subviews[3].alpha = 0;
            } else {
                tabBarButton.subviews[0].alpha = 0;
                tabBarButton.subviews[2].alpha = 1;
                tabBarButton.subviews[1].alpha = 0;
                tabBarButton.subviews[3].alpha = 1;
            }
        }];
    });
}

- (NSArray *)tabBarButtons {
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc] init];
    for (UIView *subview in self.tabBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtons addObject:subview];
        }
    };
    return tabBarButtons.copy;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    
    NSUInteger index = contentOffset.x / WXWidth;
    CGFloat mod = fmod(contentOffset.x, WXWidth);
    CGFloat deltaAlpha = mod * (1.0 / WXWidth);

    [[self tabBarButtons] enumerateObjectsUsingBlock:^(UIView *tabBarButton, NSUInteger idx, BOOL *stop) {
        if (idx == index) {
            tabBarButton.subviews[0].alpha = 1 - deltaAlpha;
            tabBarButton.subviews[2].alpha = 0 + deltaAlpha;
            tabBarButton.subviews[1].alpha = 1 - deltaAlpha;
            tabBarButton.subviews[3].alpha = 0 + deltaAlpha;
        } else if (idx == index + 1) {
            tabBarButton.subviews[0].alpha = 0 + deltaAlpha;
            tabBarButton.subviews[2].alpha = 1 - deltaAlpha;
            tabBarButton.subviews[1].alpha = 0 + deltaAlpha;
            tabBarButton.subviews[3].alpha = 1 - deltaAlpha;
        }
    }];
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    CGPoint contentOffset = scrollView.contentOffset;
//    NSUInteger index = contentOffset.x / WXWidth;
//    [[self tabBarButtons] enumerateObjectsUsingBlock:^(UIView *tabBarButton, NSUInteger idx, BOOL *stop) {
//        if (idx == index) {
//            tabBarButton.subviews[0].alpha = 1;
//            tabBarButton.subviews[2].alpha = 0;
//            tabBarButton.subviews[1].alpha = 1;
//            tabBarButton.subviews[3].alpha = 0;
//        } else {
//            tabBarButton.subviews[0].alpha = 0;
//            tabBarButton.subviews[2].alpha = 1;
//            tabBarButton.subviews[1].alpha = 0;
//            tabBarButton.subviews[3].alpha = 1;
//        }
//    }];
//}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSUInteger index = [self.backingViewControllers indexOfObject:viewController];
    
    [self.scrollView scrollRectToVisible:CGRectMake(WXWidth * index, 0, WXWidth, WXHeight) animated:NO];
    [[self tabBarButtons] enumerateObjectsUsingBlock:^(UIView *tabBarButton, NSUInteger idx, BOOL *stop) {
        if (idx == index) {
            tabBarButton.subviews[0].alpha = 1;
            tabBarButton.subviews[2].alpha = 0;
            tabBarButton.subviews[1].alpha = 1;
            tabBarButton.subviews[3].alpha = 0;
        } else {
            tabBarButton.subviews[0].alpha = 0;
            tabBarButton.subviews[2].alpha = 1;
            tabBarButton.subviews[1].alpha = 0;
            tabBarButton.subviews[3].alpha = 1;
        }
    }];
    
    return NO;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {}

@end
