//
//  MySubscribeCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "MySubscribeCell.h"
#import "NewsModel.h"
#import "NSDate+DateSincetNow.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "ColumnsTableView.h"
#import "UIImageView+SetWebPImage.h"
#import "UILabel+setTimeText.h"




@implementation MySubscribeCell
{
    __weak IBOutlet UILabel *sourceLabel;

    __weak IBOutlet UIImageView *headerIconView;
    __weak IBOutlet UIView *newView1;
    __weak IBOutlet UIView *newView2;

    __weak IBOutlet UIView *containerView;

}
- (void)awakeFromNib {
    // Initialization code

    self.selectionStyle = UITableViewCellSelectionStyleNone;

     containerView.layer.borderColor = [UIColor colorWithWhite:0.600 alpha:1.000].CGColor;
     containerView.layer.borderWidth = 1;
     containerView.layer.cornerRadius = 5;
//    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
//     self.contentView.layer.shadowOffset = CGSizeMake(5, 5);
//     self.contentView.layer.shadowRadius = 5;
//     self.contentView.layer.shadowOpacity = 0.5;

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"biz_pc_task_list_item_bg.9"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
    self.backgroundView = imageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(ColumnModel *)model{
    if (_model == model) {
        return;
    }
    _model = model;
    sourceLabel.text = _model.source;

    UIImageView *iconView;
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *replayCountLabel;

    if (_model.docs.count < 1) {
        [newView1 removeFromSuperview];
        [newView2 removeFromSuperview];
        return;
    }
    else if(_model.docs.count < 2){
        [newView2 removeFromSuperview];
    }
    UIView *view;
    for (int i = 0 ;i < _model.docs.count && i < 2;i ++) {
        if(i == 0)  view = newView1;
        else if(i == 1) view = newView2;
        else return;
        iconView = (UIImageView *)[view viewWithTag:11];
        titleLabel = (UILabel *)[view viewWithTag:12];
        timeLabel = (UILabel *)[view viewWithTag:13];;
        replayCountLabel = (UILabel *)[view viewWithTag:14];

        NewsModel *newModel = _model.docs[i];

        titleLabel.text = newModel.title;
        
#define API @"http:s.cimg.163.com/pi/img3.cache.netease.com/m/newsapp/topic_icons/%@.png.48x2147483647.75.auto.webp"
        NSString *tid = _model.tid;
        NSString *url = [NSString stringWithFormat:API,tid];
        [headerIconView setWebPImageFromURLString:url];            
        
        [iconView sd_setImageWithURL:[NSURL URLWithString:newModel.imgsrc]];

        [timeLabel setTimeText:newModel.ptime DateFormatString:@"yyyy-MM-dd HH:mm:ss"];

        if (newModel.replyCount) {
            if ([newModel.replyCount intValue]) {
                replayCountLabel.text = [newModel.replyCount stringByAppendingString:@"跟帖"];
            }else{
                replayCountLabel.text = nil;
            }
        }

    }
    [self addGestureRecognizer];
}

#pragma mark- 点击手势
-(void)addGestureRecognizer{
    UITapGestureRecognizer *newsTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openNewDetailView:)];

    [newView1 addGestureRecognizer:newsTap1];

    UITapGestureRecognizer *newsTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openNewDetailView:)];
    [newView2 addGestureRecognizer:newsTap2];

    UITapGestureRecognizer *columnsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openColunmsView:)];
    [sourceLabel.superview addGestureRecognizer:columnsTap];
}
- (void)openNewDetailView:(UITapGestureRecognizer *)sender {


    NewsModel *newModel;
    if (sender.view == newView1) {
        newModel = _model.docs[0];
    }else if(sender.view == newView2){
        newModel = _model.docs[1];
    }

    NSDictionary *parameterDictionary = @{kNewsModelKey:newModel};
    [self openNewDetailView:parameterDictionary FromView:sender.view];

}
- (void)openColunmsView:(UITapGestureRecognizer *)sender {
    NSDictionary* parameterDictionary = @{kCategoryValueKey:_model.tid,
                                          kCategoryPathKey:@"list",
                                          kPageStartKey:@(0),kPageEndKey:@(20)};
    [self openColunmsView:parameterDictionary FromView:sender.view];
}
@end
