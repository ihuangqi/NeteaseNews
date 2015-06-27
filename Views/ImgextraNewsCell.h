//
//  ImgextraNewsCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "NewsBaseCelll.h"

@interface ImgextraNewsCell : NewsBaseCelll

@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@property (nonatomic, strong) NewsModel* newsModel;
-(void)setModel:(NewsModel *)newsModel;
-(void)gotoDetialView;
@end
