//
//  Player.m
//  NeteasyNews
//
//  Created by 004 on 15/6/14.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "MediaPlayer.h"
@interface MediaPlayer()
@property (nonatomic, strong) void (^callback)();
@end

@implementation MediaPlayer
{

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
static MediaPlayer* shardPlayer;

+(Class)layerClass{
    return [AVPlayerLayer class];
}
-(AVPlayer *)player{
    return [(AVPlayerLayer *)[self layer] player];
}
-(void)setPlayer:(AVPlayer *)player{
    [(AVPlayerLayer *)[self layer] setPlayer:player];
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

- (instancetype)initWithFrame:(CGRect)frame callBack:(void (^)())callback{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

+(instancetype)shardPlayer{
    return [self shardPlayerWithFrame:CGRectZero callBack:nil];
}
+(instancetype)shardPlayerWithFrame:(CGRect)frame callBack:(void (^)())callback{
    if (shardPlayer == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            shardPlayer = [[self alloc] initWithFrame:frame callBack:(void (^)())callback];
        });
    }
    return shardPlayer;
}

-(void)setPlayItem:(AVPlayerItem *)item callBack:(void (^)())callback{
    if (item == nil) {
        return;
    }
    if(!self.player.currentItem)
    {
        self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    }else{
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
        [self.player replaceCurrentItemWithPlayerItem:item];
    }
    _callback = callback;
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

//    NSLog(@"%@",change);
    if ([keyPath isEqualToString:@"status"]) {
        //        [MBProgressHUD hideHUDForView:shardPlayerView animated:YES];
        if ([change[@"new"] intValue]==AVPlayerItemStatusReadyToPlay) {
            NSLog(@"与服务器交互成功，准备播放");
            self.isReadyToPlay = YES;
            //int _toatalSec = (int) self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
            //            if (shardPlayerView.cell.model == _model) {
            //                shardPlayerView.model.playTiemString =[NSString stringWithFormat:@"%02d:%02d",(int)_toatalSec/60,(int)_toatalSec%60];
            //                shardPla yerView.cell.timeLabel.text =[NSString stringWithFormat:@"%02d:%02d",(int)_toatalSec/60,(int)_toatalSec%60];
            //            }

            //每间隔1秒调用一次 usingBlock方法
            //防止block 内部循环调用
//            __weak __block  AVPlayer *player = self.player;
//            __weak __block MediaCell *cell = shardPlayerView.cell;
//            __weak __block MediaModel *model = shardPlayerView.model;

            __weak __block MediaPlayer *w_MediaPlayer = self;
            _timeObserver =  [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
                __strong MediaPlayer *s_MediaPlayer = w_MediaPlayer;
//                if (cell.model != model) return;
//                __unused CGFloat curSec =player.currentItem.currentTime.value/player.currentTime.timescale;
//                __unused CGFloat surplusSec = _toatalSec - curSec;
//                NSString *tiemString = [NSString stringWithFormat:@"%02d:%02d",(int)surplusSec/60,(int)surplusSec%60];
//                cell.timeLabel.text = tiemString;
//                model.playTiemString = tiemString;
//                //                ctl->proress.value=curSec/ctl->_toatalSec;
                if (s_MediaPlayer.callback) {
                    s_MediaPlayer.callback();
                }

            }];


        }
    }

}

@end
