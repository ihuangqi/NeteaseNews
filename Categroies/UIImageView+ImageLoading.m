//
//  UIImageView+ImageLoading.m
//  NeteaseNews
//
//  Created by 004 on 15/6/28.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "UIImageView+ImageLoading.h"

#import "UIImageView+WebCache.h"

@implementation UIImageView (ImageLoading)
-(void)loadImageWithUrlString:(NSString*)urlString PlaceHolderArray:(NSArray *)imageArray{
    //    [imageView sd_cancelCurrentImageLoad];
    [self sd_cancelCurrentImageLoad];
    if (!urlString || ![urlString hasPrefix:@"http://"]) {
        self.image = nil;
        return;
    }
    int contentMode = self.contentMode;
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[imageArray firstObject] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        float progress = receivedSize / (float)expectedSize;
        int index = (int)(progress);
        index >= 1 ? index = (int)imageArray.count - 1 : index;
        self.image = imageArray[index];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.contentMode = contentMode;
        self.image = image;
    }];
}
-(void)loadImageWithUrlString:(NSString*)urlString{
    NSMutableArray *imageArray = [NSMutableArray new];
    for (int i = 0; i < 10; i ++) {
        [imageArray addObject:[[UIImage imageNamed:[NSString stringWithFormat:@"loading%d",i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    [self loadImageWithUrlString:urlString PlaceHolderArray:imageArray];
}
@end
