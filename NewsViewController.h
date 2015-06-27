//
//  NewsViewController.h
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsViewIndexChangeDelegate <NSObject>

-(void)newsViewMoveToIndex:(NSInteger)toIndex FromIndex:(NSInteger)fromIndex;
-(void)indexSelected:(NSInteger)index animated:(BOOL)isAnimated;

@end

@interface NewsViewController : UIViewController<NewsViewIndexChangeDelegate>
-(void)newsViewMoveToIndex:(NSInteger)toIndex FromIndex:(NSInteger)fromIndex;
@end
