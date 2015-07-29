//
//  CategoryCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/19.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "CategoryCell.h"
#import "UIImage+ConvertFromUIImage.h"

@implementation CategoryCell
{
    UIButton *button;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, frame.size.height- 10)];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.layer.cornerRadius = 5;
        button.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1.000];
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:0.816 green:0.812 blue:0.820 alpha:1.000]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:0.890 green:0.161 blue:0.184 alpha:1.000]] forState:UIControlStateSelected];
        button.layer.cornerRadius = 10;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor colorWithRed:0.773 green:0.769 blue:0.773 alpha:1.000].CGColor;
        button.clipsToBounds = YES;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.userInteractionEnabled = NO;
        [self.contentView addSubview:button];
    }
    return self;
}
-(void)setModel:(CategoryModel *)model{
    if ([model.name isEqualToString:@"头条"]) {
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithWhite:0.965 alpha:1.000]] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor clearColor].CGColor;
    }

    [button setTitle:model.name forState:UIControlStateNormal];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    button.selected = selected;

}

@end
