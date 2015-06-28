//
//  MediaCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "MediaCell.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerView.h"
#import "UIImageView+ImageLoading.h"

@implementation MediaCell
static PlayerView *playerView;
-(void)awakeFromNib{
    _containerView.layer.borderWidth = 2;
    _containerView.layer.borderColor = [UIColor colorWithWhite:0.667 alpha:1.000].CGColor;
    _containerView.layer.cornerRadius = 10;
    _containerView.clipsToBounds = YES;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}
-(void)setModel:(MediaModel *)model{
    if (model == _model) {
        return;
    }
    _model = model;
    _titleLabel.text = _model.title;
    _playTimeLabel.text = [_model.playCount stringValue];
    _replyCountLabel.text = [[_model.replyCount stringValue] stringByAppendingString:@"跟帖"];

//    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.cover]];
    [_iconImageView loadImageWithUrlString:_model.cover];

    if (model.isPlaying == NO) {
        int time = [_model.length intValue];
        _timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",time / 60,time % 60];

        [_playButton.superview bringSubviewToFront:_playButton];
        [_mediaView.superview sendSubviewToBack:_mediaView];
    }else{
        _timeLabel.text = model.playTiemString;

        [_mediaView addSubview:playerView];
        [_mediaView.superview bringSubviewToFront:_mediaView];
    }
}

- (IBAction)playButtonClick:(UIButton *)sender {
    NSString *url = _model.m3u8_url;
    NSURL *videoUrl=[NSURL URLWithString:url];
    playerView = [PlayerView getPlayViewWithFrame:self.mediaView.bounds URL:videoUrl MediaCell:self];
    _model.isPlaying = YES;
    [_mediaView.superview bringSubviewToFront:_mediaView];

    [self.mediaView addSubview:playerView];
}
@end
