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

    [_OneImageVIew sd_setImageWithURL:[NSURL URLWithString:boboModel1.cover]];
    [_TwoImageView sd_setImageWithURL:[NSURL URLWithString:boboModel2.cover]];
    [_ThreeImageView sd_setImageWithURL:[NSURL URLWithString:muiscModel.imageUrl]];

//    [_OneImageVIew addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoWebView:)]];
//    [_TwoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoWebView:)]];
//    [_ThreeImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoWebView:)]];
//

}
-(void)gotoDetialView{

}

-(void)gotoWebView:(UITapGestureRecognizer *)sender{

}
@end
