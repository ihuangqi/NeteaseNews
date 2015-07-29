//
//  UtilityCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "UtilityCell.h"
#import "DiscoveryModel.h"
#import "RecommendDiscoveryModel.h"
#import "BannerDiscoeryModel.h"
#import "UIImageView+WebCache.h"
@interface UtilityCell()<UIScrollViewDelegate,UIWebViewDelegate>
@end

@implementation UtilityCell
{
    __weak IBOutlet UIScrollView *bannerView;
    __weak IBOutlet UIView *buttonView;
    UIPageControl *pageControl;
    NSTimer *timer;
}
-(void)awakeFromNib{
    bannerView.pagingEnabled = YES;
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"biz_guide_dialog_bg.9"] stretchableImageWithLeftCapWidth:40 topCapHeight:40]];
        self.backgroundView = backgroundView;
    }
    return self;
}
-(void)setDictionary:(NSDictionary *)dic{
    NSArray *recommend = dic[KRecommendKey];
    NSArray *banner = dic[KBannerKey];
    _recommend = recommend;
    _banner = banner;
    if (_recommend.count > 0) {
        for (int i = 0; i < _recommend.count; i ++) {
            RecommendDiscoveryModel *model = _recommend[i];
            UIButton* button = (UIButton *)[buttonView viewWithTag:10+i];
            [button setTitle:model.title forState:UIControlStateNormal];
            button.tag = 100+i;
            [button addTarget:self action:@selector(buttonCilck:) forControlEvents:UIControlEventTouchUpInside];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.icon]];
                UIImage *image = [[UIImage imageWithData:data scale:2] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [button setImage:image forState:UIControlStateNormal];
                });
            });
//            [button.imageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
        }
    }
    if (_banner.count > 0) {
        CGRect rect = bannerView.bounds;
        for (int i = 0; i < banner.count; i ++) {
            BannerDiscoeryModel *bannerModel;
            if (i == 0) {
                bannerModel = _banner[banner.count - 1];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
                [bannerView addSubview:imageView];
                rect.origin.x += bannerView.bounds.size.width;
                [imageView sd_setImageWithURL:[NSURL URLWithString:bannerModel.image]];
            }

            bannerModel = _banner[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
            imageView.tag = 200 + i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap:)]];
            [bannerView addSubview:imageView];
            rect.origin.x += bannerView.bounds.size.width;
            [imageView sd_setImageWithURL:[NSURL URLWithString:bannerModel.image]];

            if (i == _banner.count - 1) {
                bannerModel = _banner[0];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
                [bannerView addSubview:imageView];
                rect.origin.x += bannerView.bounds.size.width;
                [imageView sd_setImageWithURL:[NSURL URLWithString:bannerModel.image]];
            }
        }
        bannerView.contentSize = CGSizeMake(rect.origin.x, rect.size.height);
        bannerView.contentOffset = CGPointMake(rect.size.width,0);
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(bannerView.frame.size.width - 70, bannerView.frame.size.height - 30, 60, 15)];
        pageControl.numberOfPages = _banner.count;
        pageControl.currentPage = 0;
        pageControl.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.530];
        pageControl.layer.cornerRadius = 10;
        [bannerView.superview addSubview:pageControl];
        bannerView.delegate = self;
        bannerView.bounces = NO;
        bannerView.showsHorizontalScrollIndicator = NO;
        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timeUp) userInfo:nil repeats:YES];
    }

}

- (void)buttonCilck:(UIButton *)sender {
    NSInteger i = sender.tag - 100;
    RecommendDiscoveryModel *model = _recommend[i];
    [self gotoNextView:model.url FromView:sender];
}

- (void)imageViewDidTap:(UITapGestureRecognizer *)sender {
    NSInteger i= sender.view.tag - 200;
    BannerDiscoeryModel *model= _banner[i];
    [self gotoNextView:model.url FromView:sender.view];
}

- (void)timeUp {
    if (self.rootViewController.presentedViewController) {
        return;
    }
    int contentOffsetX = bannerView.contentOffset.x;
    contentOffsetX = ((int)(bannerView.contentOffset.x/bannerView.frame.size.width) + 1)* bannerView.frame.size.width;
    [bannerView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    int contentOffsetX = bannerView.contentOffset.x;
    if (contentOffsetX == (_banner.count+1) *bannerView.frame.size.width) {
        [bannerView setContentOffset:CGPointMake(bannerView.frame.size.width, 0) animated:NO];
    };
    int page = scrollView.contentOffset.x / bannerView.frame.size.width;
    pageControl.currentPage = page - 1;
}
@end
