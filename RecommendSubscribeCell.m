//
//  RecommendSubscribeCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "RecommendSubscribeCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+WebP.h"
#import "UIImageView+SetWebPImage.h"
#import "DetailViewController.h"
#import "ColumnsTableView.h"
#import "UIImageView+ImageLoading.h"

@implementation RecommendSubscribeCell
{
    __weak IBOutlet UIView *containerView;
    __weak IBOutlet UIImageView *iconView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *subNumLabel;
    __weak IBOutlet UIButton *subButton;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *digestLabel;
    __weak IBOutlet UIButton *addSubButton;

}
- (void)awakeFromNib {
    // Initialization code

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"biz_pic_item_bg.9"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
    self.backgroundView = imageView;

}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [addSubButton setImage:[UIImage imageNamed:@"biz_plugin_manage_check"] forState:UIControlStateNormal];
        [addSubButton setImage:[UIImage imageNamed:@"biz_plugin_manage_check_pressed"] forState:UIControlStateHighlighted];


//        containerView.layer.shadowColor = [UIColor blackColor].CGColor;
//        containerView.layer.borderColor = [UIColor colorWithWhite:0.667 alpha:1.000].CGColor;
//        containerView.layer.borderWidth = 1;
//        containerView.layer.cornerRadius = 5;
//        containerView.layer.shadowOffset = CGSizeMake(5, 5);
//        containerView.layer.shadowRadius = 5;
//        containerView.layer.shadowOpacity = 0.6;

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#define API @"http://s.cimg.163.com/pi/img3.cache.netease.com/m/newsapp/topic_icons/%@.png.80x2147483647.75.auto.webp"
-(void)setModel:(RecommendListModel *)model{
    if (_model == model) {
        return;
    }
    _model = model;

    if (model.tid) {
        NSString *tid = model.tid;
        NSString *url = [NSString stringWithFormat:API,tid];

        //    [iconView sd_setImageWithURL:[NSURL URLWithString:url]];
        [iconView setWebPImageFromURLString:url];
        iconView.layer.cornerRadius = 10;
        iconView.clipsToBounds = YES;
    }else{
        iconView.image = nil;
    }

    nameLabel.text = _model.tname;
    if (_model.subnum) {
        subNumLabel.text = [_model.subnum stringByAppendingString:@"订阅"];
    }
    titleLabel.text = _model.title;
    digestLabel.text = _model.digest;

    [self addGestureRecognizer];
}
- (IBAction)addSubscibe:(id)sender {

}

#pragma mark- 点击手势
-(void)addGestureRecognizer{
    UITapGestureRecognizer *newsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openNewDetailView:)];
    [titleLabel.superview addGestureRecognizer:newsTap];


    UITapGestureRecognizer *columnsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openColunmsView:)];
    [nameLabel.superview addGestureRecognizer:columnsTap];
}
- (void)openNewDetailView:(UITapGestureRecognizer *)sender {

    NSDictionary* parameterDictionary = @{kdocidKey:_model.docid};
    [self openNewDetailView:parameterDictionary FromView:sender.view];

}
- (void)openColunmsView:(UITapGestureRecognizer *)sender {

    NSDictionary* parameterDictionary = @{kCategoryValueKey:_model.tid,
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageEndKey:@(20)};
    [self openColunmsView:parameterDictionary FromView:sender.view];
}

@end
