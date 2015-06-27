//
//  RadioGeneralCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "RadioGeneralCell.h"
#import "RadioTemplateModel.h"
#import "UIImageView+SetWebPImage.h"
#import "UIImageView+WebCache.h"

@interface RadioGeneralCell()
{
    __weak IBOutlet UIImageView *iconView;
    __weak IBOutlet UILabel *className;
    __weak IBOutlet UIView *containerView;


}
@end
@implementation RadioGeneralCell

-(void)setModel:(RadioclassifyModel *)model{
    if (_model == model) {
        return;
    }
    _model = model;
#define IconAPI @"http://s.cimg.163.com/pi/img3.cache.netease.com/m/newsapp/topic_icons/%@.png.64x2147483647.75.auto.webp"
    NSString *urlString = [NSString stringWithFormat:IconAPI,_model.cid];
    [iconView setWebPImageFromURLString:urlString];
    className.text = model.cname;

    UIImageView *imageView;
    UIImageView *backGroundView;
    UILabel *sourceLabel;
    UILabel *titleLabel;
    UILabel *playCount;
    for (int i = 0; i < 3; i ++) {
        UIView *radioView = [containerView viewWithTag:100 + i];
        backGroundView = (UIImageView *)[radioView viewWithTag:10];
        imageView = (UIImageView *)[radioView viewWithTag:11];
        sourceLabel = (UILabel *)[radioView viewWithTag:12];
        titleLabel = (UILabel *)[radioView viewWithTag:13];
        playCount = (UILabel *)[radioView viewWithTag:22];

        backGroundView.image = nil;
        imageView.image = nil;
        sourceLabel.text = nil;
        titleLabel.text = nil;
        playCount.text = nil;
        radioView.hidden = YES;
        if (i >= _model.tList.count) {
            continue;
        }
        radioView.hidden = NO;
#define ImageAPI @"http://s.cimg.163.com/pi/img3.cache.netease.com/3g/2015/6/11/20150611162444eb6a0.jpg.207x2147483647.75.auto.webp"
//                                   http://img3.cache.netease.com/3g/2015/6/11/20150611162444eb6a0.jpg
        RadioTemplateModel *radioTemplateModel = _model.tList[i];
        RadioModel *radioModel = radioTemplateModel.radio;
        if (radioTemplateModel.playCount) {
            playCount.text = [radioTemplateModel.playCount stringValue];
        }
        [imageView sd_setImageWithURL:[NSURL URLWithString:radioModel.imgsrc]];
        backGroundView.image =[[UIImage imageNamed:@"biz_score_mall_item_bg.9"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
        sourceLabel.text = radioTemplateModel.tname;
        titleLabel.text = radioModel.title;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openRadioDetailView:)];
        [radioView addGestureRecognizer:tap];
    }

}

- (void)openRadioDetailView:(UITapGestureRecognizer *)sender {
    NSInteger i = sender.view.tag - 100;
    RadioTemplateModel *radioTemplateModel = _model.tList[i];

    [self openRadioDetailView:@{kRadioTemplateModelKey:radioTemplateModel} FromView:sender.view];
}

@end
