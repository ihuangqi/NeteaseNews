//
//  RadioPlayerView.h
//  NeteasyNews
//
//  Created by 004 on 15/6/13.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
@interface RadioPlayer : UIView
+(instancetype)sharedPlayer;

@property (nonatomic, weak) UIProgressView* progressView;
@property (nonatomic, weak) UISlider* sliderView;
@property (nonatomic, weak) UILabel* playTimeLabel;
@property (nonatomic, weak) UILabel* totalTimeLabel;

@property (nonatomic, strong) AVPlayer* player;
@property (nonatomic, strong) id timeObserver;


-(void)playOrPause;
-(void)pause;
-(void)play;
+(instancetype)getPlayerWithURL:(NSURL *)URL;

-(NSURL *)urlOfCurrentlyPlayingInPlayer:(AVPlayer *)player;

@end
