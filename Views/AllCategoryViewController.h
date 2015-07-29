//
//  AllCategoryView.h
//  NeteasyNews
//
//  Created by 004 on 15/6/19.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsViewController.h"

@interface AllCategoryViewController : UICollectionViewController
@property (nonatomic, weak) id<NewsViewIndexChangeDelegate> delegate;
-(NSInteger)selectedIndex;

- (instancetype)initWithFrame:(CGRect)Rect;

@end
