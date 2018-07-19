//
//  ViewController.m
//  WXTabBarControllerj
//
//  Created by leichunfeng on 15/11/20.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.backgrooundColor;
    NSLog(@"%@ -- %s", self.title, __FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@ -- %s", self.title, __FUNCTION__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%@ -- %s", self.title, __FUNCTION__);
}
@end
