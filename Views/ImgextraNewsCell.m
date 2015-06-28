//
//  ImgextraNewsCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "ImgextraNewsCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+ImageLoading.h"

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

//    [self setImage:_oneImageView UrlString:_newsModel.imgsrc];
//    [self setImage:_twoImageView UrlString:[_newsModel.imgextra firstObject]];
//    [self setImage:_threeImageView UrlString:[_newsModel.imgextra lastObject]];

    [_oneImageView loadImageWithUrlString:_newsModel.imgsrc];
    [_twoImageView loadImageWithUrlString:[_newsModel.imgextra firstObject]];
    [_threeImageView loadImageWithUrlString:[_newsModel.imgextra lastObject]];


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
