//
//  ColumnsTableViewCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "ColumnsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "UILabel+setTimeText.h"

@implementation ColumnsTableViewCell
{
    __weak IBOutlet UIImageView *iconView;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *digestLabel;
    __weak IBOutlet UILabel *timeLabel;
}
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"biz_pc_task_list_item_bg.9"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
    self.backgroundView = imageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(NewsModel *)model{
    if (_model == model) {
        return;
    }
    _model = model;
    if (_model.imgsrc) {
        [iconView sd_setImageWithURL:[NSURL URLWithString:_model.imgsrc]];
    }else{
        iconView.image = nil;
    }
    titleLabel.text = _model.title;
    digestLabel.text = _model.digest;
    [timeLabel setTimeText:_model.ptime DateFormatString:@"yyyy-MM-dd HH:mm:ss"];
    [self addGestureRecognizer];
}





#pragma mark- 点击手势
-(void)addGestureRecognizer{
    UITapGestureRecognizer *newsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openNewDetailView:)];
    [titleLabel.superview addGestureRecognizer:newsTap];

}
- (void)openNewDetailView:(UITapGestureRecognizer *)sender {
    NSDictionary * parameterDictionary = @{kdocidKey:_model.docid};
    [self openNewDetailView:parameterDictionary FromView:sender.view];

}

@end
