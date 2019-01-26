//
//  ShadeViewController.m
//  LL_ShadeViewController
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ShadeViewController.h"
#import "TableHeadView.h"

@interface ShadeViewController ()

@property(nonatomic,strong)NSMutableArray *dataSource;


@end

@implementation ShadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupViews];

}

-(void)setupViews{
    TableHeadView *headView = [[TableHeadView alloc] init];
    self.tableView.tableHeaderView = headView;
    
    self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height);
    self.contentHeight = self.view.frame.size.height;
    self.offsetChange = [headView getHeadViewHeight];
}

#pragma mark  ------UITableViewDelegate and UITableViewDataSource -------
//多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    //cell的选中状态 StyleNone为选中不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    //     [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0.f, 15)];
    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 54;
    
}

//组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 80;
    
}
//组头标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor redColor];
    UILabel *titleLb = [[UILabel alloc] init];
    [bgView addSubview:titleLb];
    titleLb.frame = CGRectMake(0, 0, 200, 80);
    titleLb.font = [UIFont systemFontOfSize:15];
    titleLb.textColor = [UIColor blackColor];
    titleLb.text = @"我是组头啊";
    titleLb.textAlignment = NSTextAlignmentLeft;
    
    return bgView;
}



-(NSMutableArray*)dataSource{
    
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


@end
