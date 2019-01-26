//
//  UINavigationController+StatusBar.h
//  qnche
//
//  Created by pengkang on 2017/7/4.
//  Copyright © 2017年 pengkang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (StatusBar)

-(UIStatusBarStyle)preferredStatusBarStyle;

-(UIViewController *)childViewControllerForStatusBarStyle;

-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation;


@end
