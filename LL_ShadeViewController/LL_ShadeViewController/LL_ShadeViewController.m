//
//  LL_ShadeViewController.m
//  LL_ShadeViewController
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "LL_ShadeViewController.h"

#define kDevice_iPhoneX CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size)
#define  KStatusBarAndNavigationBarHeight  (kDevice_iPhoneX ? 88.f : 64.f)
@interface LL_ShadeViewController ()
{
    CGFloat offset ;//tableview的滑动偏移
}

@property(nonatomic,strong)UIButton *rightBtn;

@end

@implementation LL_ShadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //导航栏相关
    [self setupNavigationBar];
}

-(void)setupSubView
{
    
    self.lucencyTitleColor = [UIColor whiteColor];
    self.notLucencyTitleColor = [UIColor blackColor];
    
    //设置不系统对tableview不会自动偏移处理
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //去掉导航栏的黑线
    UIImageView *iamgeV = [self findBackLineImageV:self.navigationController.navigationBar];
    iamgeV.hidden = YES;
    
    self.offsetChange = KStatusBarAndNavigationBarHeight;
    self.contentHeight = self.view.frame.size.height;
}

#pragma mark ------------ 去掉导航栏下的黑线 ---------
- (UIImageView *)findBackLineImageV:(UIView*)view{
    
    if([view isKindOfClass:[UIImageView class]] && view.frame.size.height <= 1){
        
        return (UIImageView*)view;
    }
    NSArray *viewAry = view.subviews;
    for (int i = 0; i < viewAry.count; i++) {
        
        UIView *tmpV = [self findBackLineImageV:viewAry[i]];
        if (tmpV) {
            return (UIImageView*)tmpV;
        }
    }
    return nil;
}

//状态栏颜色设置
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return self.lightStatusBar ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

#pragma mark --------- 导航栏 状态栏相关 --------------
-(void)setupNavigationBar
{
    //已经滑动过
    if (offset>0) {
        UIColor *color = [UIColor colorWithWhite:1.0 alpha:offset/self.offsetChange];
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
        if (offset >= self.offsetChange) {
            
            [self setBackNavNomal];
            
        }else{
            [self setBackNavDiaphanous];
        }
    }else{
        
        UIColor *color = [UIColor colorWithWhite:1.0 alpha:0.0];
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
        self.title = self.titles;
        [self setBackNavDiaphanous];
    }
    [self setNeedsStatusBarAppearanceUpdate];
}


//scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    offset = scrollView.contentOffset.y;
    UIColor *color = [UIColor colorWithWhite:1.0 alpha:offset/self.offsetChange];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    
    //导航栏渐变处理
    if (offset >= _offsetChange) {
        [self setBackNavNomal];
    }else{
        [self setBackNavDiaphanous];
    }
    
    //有组头需要悬浮的处理
    if (self.tableView.contentSize.height >= self.contentHeight) {
        //导航栏渐变处理
        if (offset >= _offsetChange) {
            
            self.tableView.contentInset = UIEdgeInsetsMake(KStatusBarAndNavigationBarHeight, 0, 0, 0);
        }else{
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
}

//正常不透明导航栏
-(void)setBackNavNomal
{
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: self.notLucencyTitleColor,NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [self setNavigationLeftItemWithImageName:@"more_dark"];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.lightStatusBar = NO;
}


//透明导航栏
-(void)setBackNavDiaphanous
{
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName: self.lucencyTitleColor,NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [self setNavigationLeftItemWithImageName:@"navigationBack"];
     [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.lightStatusBar = YES;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(1, 1);
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//导航栏图片设置
- (void)setNavigationLeftItemWithImageName:(NSString *)name{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


#pragma mark ------ Click -----
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    

}


#pragma mark -------- setter ----------
-(void)setRightTitle:(NSString*)rightTitle{
    _rightTitle = rightTitle;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:rightTitle forState:UIControlStateNormal];
    button.frame = (CGRect){CGPointZero,80,30};
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [button setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.rightBtn = button;
}


-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setTableFooterView:[UIView new]];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorColor = [UIColor lightGrayColor];
        
    }
    return _tableView;
}

@end
