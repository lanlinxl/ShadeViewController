//
//  TableHeadView.m
//  TableViewDemon
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TableHeadView.h"
#import "Masonry.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface TableHeadView ()

@property(nonatomic,strong)UIImageView *headImageView;
@end
@implementation TableHeadView

- (instancetype)init{

    self = [super init];
    if (self){
        
        [self setupHeadView];
        
    }
    return self;
}

-(void)setupHeadView{
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    [self addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    headImageView.image = [UIImage imageNamed:@"GrowthBgView"];
    self.headImageView = headImageView;
    
    [self layoutIfNeeded];
    float headViewHeight = CGRectGetMaxY([headImageView frame]);
 
    self.frame = CGRectMake(0, 0, SCREENWIDTH, headViewHeight);

}
-(float)getHeadViewHeight
{
    [self layoutIfNeeded];
    float headViewHeight = CGRectGetMaxY([ self.headImageView  frame]);
    
    return headViewHeight;
}


@end













