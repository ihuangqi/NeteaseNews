//
//  UIImageView+ImageLoading.h
//  NeteaseNews
//
//  Created by 004 on 15/6/28.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ImageLoading)
-(void)loadImageWithUrlString:(NSString*)urlString PlaceHolderArray:(NSArray *)imageArray;
-(void)loadImageWithUrlString:(NSString*)urlString;
@end
