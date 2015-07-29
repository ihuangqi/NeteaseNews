//
//  CustomCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/4.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "EntertainmentCell.h"
#import "MuiscModel.h"
#import "BoBoModel.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "UIImageView+ImageLoading.h"

@implementation EntertainmentCell

- (void)awakeFromNib {
    // Initialization code
    _OneImageVIew.tag = 10;
    _TwoImageView.tag = 11;
    _ThreeImageView.tag = 12;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setModel:(NSArray *)modelArray{
    _modelArray = modelArray;
    BoBoModel *boboModel1 = modelArray[0];
    BoBoModel *boboModel2 = modelArray[1];
    MuiscModel *muiscModel = modelArray[2];


    [_OneImageVIew loadImageWithUrlString:boboModel1.cover];
    [_TwoImageView loadImageWithUrlString:boboModel2.cover];
    [_ThreeImageView loadImageWithUrlString:muiscModel.imageUrl];
}
-(void)gotoDetialView{

}

-(void)gotoWebView:(UITapGestureRecognizer *)sender{

}
@end
