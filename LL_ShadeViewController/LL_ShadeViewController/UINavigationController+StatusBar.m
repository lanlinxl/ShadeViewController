//
//  UINavigationController+StatusBar.m
//  qnche
//
//  Created by pengkang on 2017/7/4.
//  Copyright © 2017年 pengkang. All rights reserved.
//

#import "UINavigationController+StatusBar.h"

@implementation UINavigationController (StatusBar)

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    return [[self topViewController] preferredStatusBarStyle];
}

-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return  UIStatusBarAnimationSlide;
}

@end
