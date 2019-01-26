//
//  RootViewController.m
//  LL_ShadeViewController
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RootViewController.h"
#import "ShadeViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipBtn setTitle:@"渐变导航栏" forState:UIControlStateNormal];
    skipBtn.backgroundColor = [UIColor redColor];
    skipBtn.frame = CGRectMake(20, 104,200,30);
    [skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipBtn];
}

-(void)skipBtnClick{
    
    ShadeViewController *vc = [[ShadeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
