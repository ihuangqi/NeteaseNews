//
//  AdvertiseCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "AdvertiseCell.h"
#import "UIImageView+WebCache.h"
#import "Activity.h"
#import "SubActivity.h"
#import "SubTemplateModel.h"
#import "TemplateModel.h"

@implementation AdvertiseCell
{
    UIImageView *imageView;
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    __weak IBOutlet UIView *containerView;
    __weak IBOutlet UIView *titleView;
    __weak IBOutlet UILabel *nameLabel;

}
- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"abc_popup_background_mtrl_mult.9"] stretchableImageWithLeftCapWidth:40 topCapHeight:40]];
        self.backgroundView = backgroundView;
    }
    return self;
}
-(void)setModel:(AdvertiseModel *)model{
    if (_model == model) {
        return;
    }
    _model = model;
    NSArray *array = _model.subItem;
    for (int i= 0; i < array.count; i ++) {
        UIView *view = [containerView viewWithTag:i+1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(childViewDidTap:)];
        [view addGestureRecognizer:tap];
        imageView = (UIImageView *)[view viewWithTag:10];
        titleLabel = (UILabel *)[view viewWithTag:11];
        subtitleLabel = (UILabel *)[view viewWithTag:12];

        AdvertiseModel *model = (AdvertiseModel *)array[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageURLPath]];
        titleLabel.text = model.titleLabeText;
        subtitleLabel.text = model.subTitleLabelText;
        if (subtitleLabel.text) {
            subtitleLabel.text = [subtitleLabel.text stringByAppendingString:@"金币"];
        }
    }
    for (int i=3; i > array.count - 1; i --) {
        UIView *view = [containerView viewWithTag:i+1];
        [view removeFromSuperview];
    }
    nameLabel.text = _model.titleLabeText;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewClick:)];
    [titleView addGestureRecognizer:tap];
}

- (void)childViewDidTap:(UITapGestureRecognizer *)sender{
    NSInteger i = sender.view.tag;
    AdvertiseModel *model = (AdvertiseModel *)_model.subItem[i - 1];
    [self gotoNextView:model.detailURL FromView:sender.view];
}

- (void)titleViewClick:(UITapGestureRecognizer *)sender{
    [self gotoNextView:_model.detailURL FromView:sender.view];
}
@end
