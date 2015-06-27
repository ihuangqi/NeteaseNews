//
//  NewsCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "NewsBaseCelll.h"

@interface NewsCell : NewsBaseCelll
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconViewWidth;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftButtomTAGLabel;


@property (weak, nonatomic) IBOutlet UILabel *scoureLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *newsPreadButton;
@property (weak, nonatomic) IBOutlet UILabel *rightButtomTAGLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyCountConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightButtomTAGLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftButtomTAGLabelWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *newsPreadButtonWidth;

@property (nonatomic, strong) NewsModel* newsModel;

-(void)setModel:(NewsModel *)newsModel;
-(void)gotoDetialView;
@end
