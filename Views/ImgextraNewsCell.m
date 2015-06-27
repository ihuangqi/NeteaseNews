//
//  ImgextraNewsCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "ImgextraNewsCell.h"
#import "UIImageView+WebCache.h"
@implementation ImgextraNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(NewsModel *)newsModel{
    if (newsModel && newsModel == _newsModel) {
        return ;
    }
    _newsModel = newsModel;
    _titleLabel.text = _newsModel.title;
    [_oneImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.imgsrc] placeholderImage:nil];
    [_twoImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.imgextra[0]] placeholderImage:nil];
    [_threeImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.imgextra[1]] placeholderImage:nil];

    _replyCountLabel.text = nil;
    if (_newsModel.isShowPeplyCount) {
        _replyCountLabel.text = [_newsModel.replyCount stringByAppendingString:@"跟帖"];
    }
}

-(void)gotoDetialView{
    NSDictionary *parameterDictionary = @{kNewsModelKey : _newsModel};
    [self gotoDetialView:parameterDictionary];
}
@end
