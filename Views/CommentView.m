//
//  CommentView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/6.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "CommentView.h"
#import "UIImageView+WebCache.h"
@implementation CommentView

-(void)setModel:(CommentModel *)model{
    if (model == nil) {
        [self removeFromSuperview];
    }
    if(model.timg && [model.timg isKindOfClass:[NSString class]]){
        [_iconView sd_setImageWithURL:[NSURL URLWithString:model.timg]];
    }else{
        _iconView.image = [UIImage imageNamed:@"biz_topic_micro_netease_big_type"];
    }
    if(model.n && [model.n isKindOfClass:[NSString class]]){
        _nickLabel.text = model.n;
    }else{
        _nickLabel.text = @"火星网友";
    }
    _timeLabel.text = model.t;
    _locationLabel.text = model.f;
    _commentLabel.text = model.b;
    self.superview.layer.cornerRadius = 5;
    self.superview.layer.borderColor = [UIColor colorWithWhite:0.667 alpha:1.000].CGColor;
    self.superview.layer.borderWidth = 1;
}

@end
