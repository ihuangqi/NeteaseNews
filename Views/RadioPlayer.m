//
//  RadioPlayerView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/13.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "RadioPlayer.h"
//
//  PlayerView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#import "MBProgressHUD.h"
@interface RadioPlayer()
{
    int toatalSec;
}
@end

@implementation RadioPlayer


+(Class)layerClass{

    return [AVPlayerLayer class];

}
-(AVPlayer *)player{
    return [(AVPlayerLayer*)[self layer] player];
}
-(void)setPlayer:(AVPlayer *)player{
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}



static RadioPlayer* sharedPlayer = nil;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

+(instancetype)sharedPlayer{

    if (sharedPlayer == nil) {
        sharedPlayer = [[RadioPlayer alloc] init];
    }
    return sharedPlayer;
}
-(void)playOrPause{
    if ([self isPlaying]) {
        [self pause];
    }else{
        [self play];
    }
}
-(void)stop{

}

-(void)play{
    [self.player play];
}
-(void)pause{
    [self.player pause];
}
-(BOOL)isPlaying{
    if (self.player.rate == 1.0) {

        return YES;

    } else {

        return NO;

    }
}

+(instancetype)getPlayerWithURL:(NSURL *)URL{
    if ([[sharedPlayer urlOfCurrentlyPlayingInPlayer:sharedPlayer.player] isEqual:URL]) {
        return sharedPlayer;
    }
    if (sharedPlayer == nil) {
        [self sharedPlayer];
    }
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:URL];
    [sharedPlayer.player removeTimeObserver:sharedPlayer.timeObserver];
    sharedPlayer.timeObserver = nil;
    if (sharedPlayer.player.currentItem) {
        [sharedPlayer.player.currentItem removeObserver:sharedPlayer forKeyPath:@"status"];
        [sharedPlayer.player replaceCurrentItemWithPlayerItem:item];
    }else{
        sharedPlayer.player = [AVPlayer playerWithPlayerItem:item];
    }
    [sharedPlayer.player.currentItem addObserver:sharedPlayer forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    sharedPlayer.sliderView.enabled = NO;
    return sharedPlayer;
}

-(NSURL *)urlOfCurrentlyPlayingInPlayer:(AVPlayer *)player{
    // get current asset
    AVAsset *currentPlayerAsset = player.currentItem.asset;
    // make sure the current asset is an AVURLAsset
    if (![currentPlayerAsset isKindOfClass:AVURLAsset.class]) return nil;
    // return the NSURL
    return [(AVURLAsset *)currentPlayerAsset URL];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"%@",change);
    if ([keyPath isEqualToString:@"status"]) {
        if ([change[@"new"] intValue]==AVPlayerItemStatusReadyToPlay) {
            NSLog(@"与服务器交互成功，准备播放");
            [self.player play];
            _sliderView.enabled = YES;
            [self.sliderView addTarget:self action:@selector(movieProgressDragged:) forControlEvents:UIControlEventValueChanged];
            int _toatalSec = (int) self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
            toatalSec = _toatalSec;
            sharedPlayer.totalTimeLabel.text =[NSString stringWithFormat:@"%02d:%02d",(int)_toatalSec/60,(int)_toatalSec%60];
            sharedPlayer.progressView.progress = 0;
            sharedPlayer.sliderView.value = 0;
            //每间隔1秒调用一次 usingBlock方法
            //防止block 内部循环调用
            __weak __block  AVPlayer *player = self.player;
            _timeObserver =  [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
                __unused CGFloat curSec =player.currentItem.currentTime.value/player.currentTime.timescale;
//                __unused CGFloat surplusSec = _toatalSec - curSec;
                __unused CGFloat surplusSec = curSec;
                NSString *tiemString = [NSString stringWithFormat:@"%02d:%02d",(int)surplusSec/60,(int)surplusSec%60];

                sharedPlayer.playTimeLabel.text = tiemString;
                float progess = curSec / _toatalSec;
                sharedPlayer.progressView.progress = progess;
                sharedPlayer.sliderView.value = progess;

            }];


        }
    }

}

-(void)movieProgressDragged:(UISlider *)sender{

    //拖动改变视频播放进度

    //计算出拖动的当前秒数
    if (toatalSec == 0) {
        return;
    }
    NSInteger dragedSeconds = floorf(toatalSec * sender.value * sender.maximumValue);

//    NSLog(@"dragedSeconds:%ld",dragedSeconds);

    //转换成CMTime才能给player来控制播放进度

    CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
    [self pause];
    [self.player seekToTime:dragedCMTime completionHandler:^(BOOL finish){
        [self play];
    }];

}

@end
