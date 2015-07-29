//
//  AllCategoryHeaderView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/24.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "AllCategoryHeaderView.h"

@implementation AllCategoryHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width-5, self.frame.size.height)];
        label.text = @"切换栏目";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:17];
        [self addSubview:label];
    }
    return self;
}
@end
