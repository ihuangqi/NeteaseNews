//
//  PlayerView.h
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "MediaPlayer.h"
#import "VideoModel.h"

@interface VideoPlayer : UIView
{
    VideoModel *model;
    void (^callBack)();
}

@property (nonatomic, strong) VideoModel* model;
+(instancetype)getPlayerWithFrame:(CGRect)frame URL:(NSURL *)URL;

@end
