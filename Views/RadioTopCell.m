//
//  RadioTopCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "RadioTopCell.h"
#import "UIImageView+WebCache.h"
#import "RadioDetailModel.h"
#import "DownloadManager.h"
@interface RadioTopCell()
{
    NSMutableArray* dataArray;
}
@end
@implementation RadioTopCell
{
    __weak IBOutlet UIImageView *imgView;

}
-(void)setModel:(RadioTemplateModel *)model{
    if (_model == model) {
        return;
    }
    _model = model;
    [imgView sd_setImageWithURL:[NSURL URLWithString:_model.radio.imgsrc]];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openRadioDetailView:)];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:tap];



}


- (void)openRadioDetailView:(UITapGestureRecognizer *)sender {

    RadioTemplateModel *radioTemplateModel = _model;

    [self openRadioDetailView:@{kRadioTemplateModelKey:radioTemplateModel} FromView:sender.view];
}








#define kLoctionRadioKey @"LoctionRadio"

- (IBAction)openMyDownload:(UIButton *)sender {

    dataArray = [DownloadManager getDetailModelFromLocationAndCallBack:^{
        [self openRadioDetailView:@{kLoctionRadioKey:dataArray } FromView:sender];
    }];
}



@end
