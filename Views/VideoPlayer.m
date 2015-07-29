


//  PlayerView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "VideoPlayer.h"
#import "MBProgressHUD.h"
@interface VideoPlayer()
{
    AVPlayerItem *item;
    UIImageView *imageView;
    
}
@end

@implementation VideoPlayer

static MediaPlayer *mediaPlayer = nil;

- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)URL
{
    self = [super initWithFrame:frame];
    if (self) {
        mediaPlayer = [MediaPlayer shardPlayerWithFrame:frame callBack:nil];
        item = [[AVPlayerItem alloc] initWithURL:URL];
        [self setItem];
        [self addSubview:mediaPlayer];
        [self bringSubviewToFront:mediaPlayer];

        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        imageView.center = CGPointMake(frame.size.width / 2, frame.size.height/2);
        imageView.image = [UIImage imageNamed:@"big_play"];
        [self addSubview:imageView];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [self addGestureRecognizer:tap];

    }
    return self;
}
+(instancetype)getPlayerWithFrame:(CGRect)frame URL:(NSURL *)URL{
    VideoPlayer *player = [[VideoPlayer alloc] initWithFrame:frame URL:URL];
    return player;
}
- (void)didTap:(id)sender {
    if(mediaPlayer.player.currentItem != self->item)
    {
        [self setItem];
    }
    if (mediaPlayer.isPlaying) {
        imageView.image = [UIImage imageNamed:@"night_biz_audio_btn_pause"];
        [imageView.superview bringSubviewToFront:imageView];
    }else{
        [imageView.superview sendSubviewToBack:imageView];
    }
    [mediaPlayer playOrPause];
}
-(void)setItem{
    if (self->item == nil) {
        return;
    }
    if(mediaPlayer.player.currentItem != self->item)
    {
        [mediaPlayer setPlayItem:self->item callBack:nil];
    }
}
-(void)removeFromSuperview{
    [mediaPlayer.player pause];
    [super removeFromSuperview];
}
@end
