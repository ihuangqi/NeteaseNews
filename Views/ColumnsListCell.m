//
//  ColumnsListCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "ColumnsListCell.h"
#import "UIImageView+SetWebPImage.h"
@implementation ColumnsListCell
{
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UIImageView *iconView;
    __weak IBOutlet UILabel *subNumLabel;

    UITapGestureRecognizer *columnsTap;

}
- (void)awakeFromNib {
    // Initialization code


}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"base_actionbar_overflow_bg.9"] stretchableImageWithLeftCapWidth:40 topCapHeight:40]];
        self.backgroundView = imageView;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(ColumnsModel *)model{
    if (_model == model) {
        return;
    }
    _model = model;
    nameLabel.text = _model.tname;
    subNumLabel.text = _model.subnum ? [_model.subnum stringByAppendingString:@"订阅"] : nil;
#define API @"http://s.cimg.163.com/pi/img3.cache.netease.com/m/newsapp/topic_icons/%@.png.80x2147483647.75.auto.webp"
    [iconView setWebPImageFromURLString:[NSString stringWithFormat:API,model.tid]];
    iconView.layer.cornerRadius = 10;
    iconView.clipsToBounds = YES;

    [self addGestureRecognizer];
}



#pragma mark- 点击手势
-(void)addGestureRecognizer{
    [self.contentView removeGestureRecognizer:columnsTap];
    columnsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openColunmsView:)];
    [self.contentView addGestureRecognizer:columnsTap];
}

- (void)openColunmsView:(UITapGestureRecognizer *)sender {
    [self.rootViewController.view endEditing:YES];
    NSDictionary* parameterDictionary = @{kCategoryValueKey:_model.tid,
                                          kCategoryPathKey:@"list",
                                          kPageStartKey:@(0),kPageEndKey:@(20)};
    [self openColunmsView:parameterDictionary FromView:sender.view];
}

- (IBAction)addButton:(id)sender {
    
}

@end
