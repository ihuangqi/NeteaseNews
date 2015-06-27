//
//  NewsCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
@implementation NewsCell
{
    __weak IBOutlet NSLayoutConstraint *videoTAGWidth;
    
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(NewsModel *)newsModel
{
    if (newsModel && newsModel == _newsModel)
    {
        return;
    }
    _newsModel = newsModel;

    if ([_newsModel.imgsrc length] > 0)
    {
        [_iconView sd_setImageWithURL:[NSURL URLWithString:_newsModel.imgsrc] placeholderImage:nil];
        _iconViewWidth.constant = 90;
    }
    else
    {
        _iconViewWidth.constant = 0;
    }
    _titleLabel.text = _newsModel.title;

    _digestLabel.text = nil;
    if (_newsModel.isShowDigest)
    {
        _digestLabel.text = _newsModel.digest;
    }

    _scoureLabel.text = nil;
    if (_newsModel.isShowSource)
    {
        _scoureLabel.text = _newsModel.source;
    }

    _replyCountConstraint.constant = 2;

    if([_newsModel.TAG isEqualToString:@"视频"]){
        
        videoTAGWidth.constant = 20;
    }else{
        videoTAGWidth.constant = 0;
    }
    
    [self showReplyCount:_newsModel.isShowPeplyCount];
    [self showTAG:_newsModel.showLoactionOfTag];
    [self showReplyCount:_newsModel.isShowPeplyCount];
    [self showNewPreadButton:_newsModel.isShowPeplyCount];
}

- (void)showTAG:(enum ShowLocation)showLocation
{
    if (!_newsModel.TAG)
    {
        showLocation = ShowLocationNone;
    }
    UILabel *label;
    NSLayoutConstraint *constraint;
    _leftButtomTAGLabel.text = nil;
    _leftButtomTAGLabelWidth.constant = 0;
    _rightButtomTAGLabel.text = nil;
    _rightButtomTAGLabelWidth.constant = 0;

    switch (showLocation)
    {
        case ShowLocationNone:
            return;
            break;
        case ShowLocationLeftTop:
        {
            break;
        }
        case ShowLocationLeftButtom:
        {
            label = _leftButtomTAGLabel;
            constraint = _leftButtomTAGLabelWidth;
            break;
        }
        case ShowLocationRightTop:
        {
            break;
        }
        case ShowLocationRightButtom:
        {
            label = _rightButtomTAGLabel;
            constraint = _rightButtomTAGLabelWidth;
            break;
        }
    }
    label.text = _newsModel.TAG;
    constraint.constant = 35;
    if ([_newsModel.TAG isEqualToString:@"推荐"] || [_newsModel.TAG isEqualToString:@"直播"])
    {
        label.textColor = [UIColor blueColor];
    }
    else if ([_newsModel.TAG isEqualToString:@"推广"])
    {
        label.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    }
    else
    {
        label.textColor = [UIColor redColor];
    }
    label.layer.borderColor = [UIColor colorWithWhite:0.298 alpha:1.000].CGColor;
    label.layer.borderWidth = 1;
}
- (void)showReplyCount:(BOOL)isShow
{
    if ([_newsModel.replyCount intValue] < 1)
    {
        isShow = false;
    }
    if (isShow)
    {
        _replyCountLabel.text = [_newsModel.replyCount stringByAppendingString:@"跟帖"];
    }
    else
    {
        _replyCountLabel.text = nil;
    }
}
- (void)showNewPreadButton:(BOOL)isShow
{
    if (_newsModel.isShowNewPreadButton == NO)
    {
        _newsPreadButton.hidden = YES;
        _newsPreadButtonWidth.constant = 0;
    }
    else
    {
        _newsPreadButton.hidden = NO;
        _newsPreadButtonWidth.constant = 33;
    }
}
-(void)gotoDetialView{
    NSDictionary *parameterDictionary = @{kNewsModelKey : _newsModel};
    [self gotoDetialView:parameterDictionary];
}
@end
