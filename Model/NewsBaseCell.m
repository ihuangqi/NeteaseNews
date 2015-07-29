//
//  NewsBaseModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/15.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "NewsBaseCelll.h"
#import "DetailViewController.h"

#import "UIImageView+WebCache.h"

#define kRootControllerKey @"RootController"

@implementation NewsBaseCelll
- (void)gotoDetialView:(NSDictionary *)dic
{
    if (!_rootViewController || dic == nil)
    {
        return;
    }

    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.parameterDictionary = dic;
    if ([_rootViewController isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)_rootViewController pushViewController:detailViewController animated:YES];
    }

}

-(void)setImage:(UIImageView *)imageView UrlString:(NSString*)urlString{
//    [imageView sd_cancelCurrentImageLoad];
    [imageView sd_cancelCurrentImageLoad];
    if (!urlString || ![urlString hasPrefix:@"http://"]) {
        imageView.image = nil;
        return;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[[UIImage imageNamed:@"loading0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        imageView.image = [[UIImage imageNamed:[NSString stringWithFormat:@"loading%d",(int)(receivedSize / (float)expectedSize * 10)]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.image = image;
    }];
}
@end
