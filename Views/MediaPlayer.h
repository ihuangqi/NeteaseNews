//
//  Player.h
//  NeteasyNews
//
//  Created by 004 on 15/6/14.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface MediaPlayer : UIView
@property (nonatomic, strong) AVPlayer* player;
@property (nonatomic, strong) id timeObserver;
@property (nonatomic, assign) BOOL isReadyToPlay;
-(void)setPlayItem:(AVPlayerItem *)item callBack:(void (^)())callback;
-(BOOL)isPlaying;
-(void)playOrPause;
+(instancetype)shardPlayerWithFrame:(CGRect)frame callBack:(void (^)())callback;
@end
