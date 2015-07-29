


//  PlayerView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "PlayerView.h"
#import "MBProgressHUD.h"
@interface PlayerView()
{

}
@end

@implementation PlayerView


static PlayerView* shardPlayerView;

+(Class)layerClass{

    return [AVPlayerLayer class];
}
-(AVPlayer *)player{
    return [(AVPlayerLayer*)[self layer] player];
}

-(void)setPlayer:(AVPlayer *)player{
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}
- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)URL
{
    self = [super initWithFrame:frame];
    if (self) {
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:URL];
        self.player = [[AVPlayer alloc] initWithPlayerItem:item];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.player play];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


+(PlayerView *)getPlayViewWithFrame:(CGRect)frame URL:(NSURL *)URL MediaCell:(MediaCell *)cell{
    if (shardPlayerView == nil) {
        shardPlayerView = [[PlayerView alloc] initWithFrame:frame URL:URL];
        [shardPlayerView.player.currentItem addObserver:shardPlayerView forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        shardPlayerView.model = cell.model;
        shardPlayerView.cell = cell;
        [MBProgressHUD showHUDAddedTo:shardPlayerView animated:YES];
        return shardPlayerView;
    }
    if (cell.model == shardPlayerView.model) {
        return shardPlayerView;
    }

    shardPlayerView.model.isPlaying = NO;
    [shardPlayerView removeFromSuperview];
    shardPlayerView.cell.model = nil;
    [shardPlayerView.cell setModel:shardPlayerView.model];
    shardPlayerView.model = cell.model;
    shardPlayerView.cell = cell;


    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:URL];
    [shardPlayerView.player.currentItem removeObserver:shardPlayerView forKeyPath:@"status"];
    [shardPlayerView.player removeTimeObserver:shardPlayerView.timeObserver];
    [shardPlayerView.player replaceCurrentItemWithPlayerItem:item];

    [MBProgressHUD showHUDAddedTo:shardPlayerView animated:YES];
    [shardPlayerView.player.currentItem addObserver:shardPlayerView forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    return shardPlayerView;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    NSLog(@"%@",change);
    if ([keyPath isEqualToString:@"status"]) {
    [MBProgressHUD hideHUDForView:shardPlayerView animated:YES];
        if ([change[@"new"] intValue]==AVPlayerItemStatusReadyToPlay) {
            NSLog(@"与服务器交互成功，准备播放");
            int _toatalSec = (int) self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
            if (shardPlayerView.cell.model == _model) {
                shardPlayerView.model.playTiemString =[NSString stringWithFormat:@"%02d:%02d",(int)_toatalSec/60,(int)_toatalSec%60];
                shardPlayerView.cell.timeLabel.text =[NSString stringWithFormat:@"%02d:%02d",(int)_toatalSec/60,(int)_toatalSec%60];
            }

            //每间隔1秒调用一次 usingBlock方法
            //防止block 内部循环调用
            __weak __block  AVPlayer *player = self.player;
            __weak __block MediaCell *cell = shardPlayerView.cell;
            __weak __block MediaModel *model = shardPlayerView.model;
            _timeObserver =  [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
                if (cell.model != model) return;
                __unused CGFloat curSec =player.currentItem.currentTime.value/player.currentTime.timescale;
                __unused CGFloat surplusSec = _toatalSec - curSec;
               NSString *tiemString = [NSString stringWithFormat:@"%02d:%02d",(int)surplusSec/60,(int)surplusSec%60];
                cell.timeLabel.text = tiemString;
                model.playTiemString = tiemString;
               //                ctl->proress.value=curSec/ctl->_toatalSec;

            }];


        }
    }

}

- (void)didTap:(id)sender {
    [self playOrPause];
}
-(void)playOrPause{
    if ([self isPlaying]) {
        [self.player pause];
    }else{
        [self.player play];
    }
}
-(BOOL)isPlaying{
    if (self.player.rate == 1.0) {

        return YES;

    } else {

        return NO;

    }
}

@end
