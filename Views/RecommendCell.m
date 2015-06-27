//
//  RecommendCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "RecommendCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+SetWebPImage.h"
#import "DetailViewController.h"
#import "ColumnsTableView.h"

@implementation RecommendCell
{
    __weak IBOutlet UIImageView *iconView;
    __weak IBOutlet UIView *containerView;
    __weak IBOutlet UIView *pictureAndContentView;

    __weak IBOutlet UILabel *sourceLabel;
    __weak IBOutlet UIButton *goodButton;
    __weak IBOutlet NSLayoutConstraint *iconImageViewWidth;
//    __weak IBOutlet UIView *threePictureView;
//    __weak IBOutlet UIView *bigPictureView;
//    __weak IBOutlet UIView *smallPictureView;
//    __weak IBOutlet UIView *nonePictureView;
//    UIView *threePictureView;
//    UIView *bigPictureView;
//    UIView *smallPictureView;
//    UIView *nonePictureView;
}
//static UIView *threePictureView;
//static UIView *bigPictureView;
//static UIView *smallPictureView;
//static UIView *nonePictureView;

int spaceWidth = 2;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    containerView.layer.borderColor = [UIColor colorWithWhite:0.667 alpha:1.000].CGColor;
    containerView.layer.borderWidth = 1;
    containerView.layer.cornerRadius = 5;
//    containerView.layer.shadowColor = [UIColor blackColor].CGColor;
//    containerView.layer.shadowOffset = CGSizeMake(10, 10);
//    containerView.layer.shadowRadius = 5;
//    containerView.layer.shadowOpacity = 0.6;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"biz_pc_account_register_btn_normal.9"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
    self.backgroundView = imageView;
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {

//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//           {
//                threePictureView = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][0];
//                bigPictureView = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][1];
//                smallPictureView = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][2];
//                nonePictureView = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][3];
//            }
//        });
//        [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:self options:nil];
//        threePictureView = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][0];
//        bigPictureView = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][1];
//        smallPictureView = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][2];
//        nonePictureView = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][3];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(RecommendModel *)model{
    if (_model == model) {
        return;
    }
    _model = model;
    [self addGestureRecognizer];
    UIView *view;
    if (_model.imgnewextra.count > 0) {
        view = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][0];
        UIImageView* bigImageView  =(UIImageView *)[view viewWithTag:11];
        UIImageView* smallImageView1  =(UIImageView *)[view viewWithTag:12];
        UIImageView* smallImageView2  =(UIImageView *)[view viewWithTag:13];

        [bigImageView sd_setImageWithURL:[NSURL URLWithString:_model.img]];
        [smallImageView1 sd_setImageWithURL:[NSURL URLWithString:_model.imgnewextra[0]]];
        [smallImageView2 sd_setImageWithURL:[NSURL URLWithString:_model.imgnewextra[1]]];

    }else{
        NSString *string = _model.pixel;
        if (model.pixel == nil) {
            if(_model.imgsrc != nil)
            {
                view = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][2];
            }else{
                view = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][3];
            }
        }else{
            int width = [[string componentsSeparatedByString:@"*"][0] intValue];
//            int height = [[string componentsSeparatedByString:@"*"][1] intValue];
            if (width >= 500) {
                view = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][1];
            }else{
                view = [[NSBundle mainBundle] loadNibNamed:@"PictureAndContent" owner:nil options:nil][2];
            }
            UIImageView *imageView = (UIImageView *)[view viewWithTag:11];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_model.img]];
        }
    }

    UILabel* titleLabel = (UILabel *)[view viewWithTag:14];
    UILabel* contectLabel = (UILabel *)[view viewWithTag:15];
    titleLabel.text = _model.title;
    contectLabel.text = _model.digest;
    if (pictureAndContentView.subviews.count > 0) {
        if (view == pictureAndContentView.subviews[0]) {
            return;
        }else{
            for (UIView *subView in pictureAndContentView.subviews) {
                [subView removeFromSuperview];
            }
        }
    }
#define API @"http:s.cimg.163.com/pi/img3.cache.netease.com/m/newsapp/topic_icons/%@.png.48x2147483647.75.auto.webp"
    if (_model.tid) {
        NSString *tid = _model.tid;
        NSString *url = [NSString stringWithFormat:API,tid];
        //    [iconView sd_setImageWithURL:[NSURL URLWithString:url]];
        [iconView setWebPImageFromURLString:url];
        iconImageViewWidth.constant = 25;
        iconView.layer.cornerRadius = 5;
        iconView.clipsToBounds = YES;

    }else{
        iconView.image = nil;
        iconImageViewWidth.constant = 0;
    }
    sourceLabel.text = _model.source;
    [goodButton setTitle:[_model.upTimes stringValue] forState:UIControlStateNormal];



    [pictureAndContentView addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    [pictureAndContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:views]];
    [pictureAndContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];


//    [pictureAndContentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:pictureAndContentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
//    [pictureAndContentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:pictureAndContentView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
//    [pictureAndContentView needsUpdateConstraints];
}

#pragma mark- 点击手势
-(void)addGestureRecognizer{
    UITapGestureRecognizer *newsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openNewDetailView:)];
    [pictureAndContentView addGestureRecognizer:newsTap];


    UITapGestureRecognizer *columnsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openColunmsView:)];
    [sourceLabel addGestureRecognizer:columnsTap];
}
- (void)openNewDetailView:(UITapGestureRecognizer *)sender {
    NSDictionary* parameterDictionary = @{kdocidKey:_model.docid};
    [self openNewDetailView:parameterDictionary FromView:sender.view];

}
- (void)openColunmsView:(UITapGestureRecognizer *)sender {

    NSDictionary* parameterDictionary = @{kCategoryValueKey:_model.tid,
                                          kCategoryPathKey:@"list",
                                          kPageStartKey:@(0),kPageEndKey:@(20)};
    [self openNewDetailView:parameterDictionary FromView:sender.view];
}


@end
