//
//  RadioDetialTableViewCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/13.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "RadioDetialTableViewCell.h"
#import "NSDate+DateSincetNow.h"
#import "UILabel+setTimeText.h"
#import "DownloadManager.h"

@implementation RadioDetialTableViewCell
{
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UIProgressView *downloadProgress;
    __weak IBOutlet UIImageView *iconVIew;
    __weak IBOutlet UILabel *downloadLabel;
    __weak IBOutlet UIButton *downloadButton;
}
- (void)awakeFromNib {
    // Initialization code
    downloadProgress.hidden = YES;
    iconVIew.hidden = YES;
    downloadLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(RadioListModel *)model{
    if (_model == model) {
        return;
    }
    _model = model;
    _model.cell = self;
    [self loadView];
}
-(void)loadView{
    titleLabel.text = _model.title;
    [timeLabel setTimeText:_model.ptime DateFormatString:@"yyyy-MM-dd HH:mm:ss"];
    if (_model.isTop) {
        titleLabel.textColor = [UIColor redColor];
        iconVIew.hidden = NO;
    }else{
        titleLabel.textColor = [UIColor blackColor];
        iconVIew.hidden = YES;
    }

    switch (_model.downloadState) {

        case DownloadNone: {
            downloadProgress.hidden = YES;
            downloadLabel.hidden = YES;
            [downloadButton setImage:[UIImage imageNamed:@"biz_audio_play_list_download_icon"] forState:UIControlStateNormal];
            break;
        }
        case DownloadStart: {
            downloadProgress.hidden = NO;
            downloadLabel.hidden = YES;
            [downloadButton setImage:[UIImage imageNamed:@"biz_audio_play_list_download_icon"] forState:UIControlStateNormal];
            break;
        }
        case DownloadDone: {
            downloadProgress.hidden = YES;
            downloadLabel.hidden = NO;
            downloadLabel.text = @"下载完成";
            [downloadButton setImage:[UIImage imageNamed:@"biz_media_subscribed_list_item_delete_pressed"] forState:UIControlStateNormal];
            break;
        }
        case DownloadFail: {
            downloadProgress.hidden = YES;
            downloadLabel.hidden = NO;
            downloadLabel.text = @"下载失败";
            [downloadButton setImage:[UIImage imageNamed:@"biz_audio_play_list_download_icon"] forState:UIControlStateNormal];
            break;
        }
        default: {
            [downloadButton setImage:[UIImage imageNamed:@"biz_audio_play_list_download_icon"] forState:UIControlStateNormal];
            break;
        }
    }
}
- (IBAction)downloadButtoClick:(UIButton *)sender {
    if (_model.downloadState != DownloadDone) {
        
        [[DownloadManager sharedManager] addDownloadFromModel:_model setProgessBlack:^(float progress) {
            NSLog(@"下载进度%f",progress);
            downloadProgress.progress = progress;
            if (self.model.cell == self) {
                [self loadView];
            }
            
        }];
        _model.downloadState = DownloadStart;
        [self loadView];
    }else{
        [[DownloadManager sharedManager] remove:_model.docid];
        _model.downloadState = DownloadNone;
        [self loadView];
    }
}

@end
