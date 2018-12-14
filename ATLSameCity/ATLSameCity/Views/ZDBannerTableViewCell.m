//
//  ZDBannerTableViewCell.m
//  Real
//
//  Created by AIlls on 2017/11/8.
//  Copyright © 2017年 真的网络科技公司. All rights reserved.
//

#import "ZDBannerTableViewCell.h"
#import "SDCycleScrollView.h"

@interface ZDBannerTableViewCell()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *iconVIew;
@property (nonatomic,strong)NSArray  *bannerArray;

@property (nonatomic,strong)NSMutableArray *redPointArray;

@end

@implementation ZDBannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [self.pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
}

- (void)setDataSource:(NSArray *)dataSource
{
    //banner
    self.bannerArray = dataSource;
    NSMutableArray *imgAry = [NSMutableArray array];
    for (NSInteger i=0; i<self.bannerArray.count; i++) {
        UIImage *image = self.bannerArray[i];
        [imgAry addObject:image];
    }
    self.pageControl.numberOfPages = imgAry.count;
    self.bannerView.localizationImageNamesGroup = imgAry;
    self.bannerView.showPageControl = NO;
    self.bannerView.delegate = self;
    
    CGFloat imageWidth = 40;
    CGFloat spacingWidth = (ScreenWidth - imageWidth * 4)/4;//间隔宽度
    NSArray *navImg = @[@"1",@"2",@"3",@"4"];
    NSArray *navIconAry = @[@"同城爆料",@"求职招聘",@"同城拼车",@"租房售房"];
    for (UIView *view in self.iconVIew.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < navIconAry.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(spacingWidth/2 + i*(spacingWidth + imageWidth), 20,imageWidth, imageWidth)];
        imageView.image = [UIImage imageNamed:navImg[i]];
        [self.iconVIew addSubview:imageView];

        NSString *labelNavName = [navIconAry objectAtIndex:i];

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*(ScreenWidth/4), 20+imageWidth+7,ScreenWidth/4, 12)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blackColor];
        label.text = labelNavName;
        [self.iconVIew addSubview:label];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(ScreenWidth/4), 10,ScreenWidth/4, 66);
        [button addTarget:self action:@selector(selectIcon:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.iconVIew addSubview:button];
    }
  
}

-(void) selectIcon:(UIButton*) button{
    NSArray *navIconAry = @[@"同城爆料",@"求职招聘",@"同城拼车",@"租房售房"];
    NSString *str = navIconAry[button.tag];
    [self.delegate selectNavItemWithType:str];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //点击的bananer
    NSString *str = [NSString stringWithFormat:@"%ld", index];
    [self.delegate pushToOtherViewControllerwithHomeItem:str];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    self.pageControl.currentPage = index;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}



@end
