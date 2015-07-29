//
//  PlayerView.h
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MediaCell.h"
@interface PlayerView : UIView
@property (nonatomic, strong) AVPlayer* player;
@property (nonatomic, strong) id timeObserver;

@property (nonatomic, strong) MediaCell *cell;
@property (nonatomic, strong) MediaModel *model;

+(PlayerView *)getPlayViewWithFrame:(CGRect)frame URL:(NSURL *)URL MediaCell:(MediaCell *)cell;
-(BOOL)isPlaying;
@end
