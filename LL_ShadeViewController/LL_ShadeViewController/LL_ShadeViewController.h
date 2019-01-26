//
//  LL_ShadeViewController.h
//  LL_ShadeViewController
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LL_ShadeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)BOOL lightStatusBar;//状态栏的颜色控制

@property(nonatomic,assign)CGFloat offsetChange;//没组头一般默认64就行，有组头则为组头到顶部的距离

@property(nonatomic,assign)CGFloat contentHeight;//内容高度，默认为self.view.frame.size.height

@property(nonatomic,strong)NSString *titles;//标题

@property(nonatomic,strong)UIColor *lucencyTitleColor;//透明导航栏标题颜色

@property(nonatomic,strong)UIColor *notLucencyTitleColor;//非透明导航栏标题颜色

@property(nonatomic,strong)NSString *rightTitle;//右侧标题



@end

NS_ASSUME_NONNULL_END
