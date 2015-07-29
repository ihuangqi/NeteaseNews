//
//  AllCategoryFooterView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/24.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "AllCategoryFooterView.h"

@implementation AllCategoryFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-5, self.frame.size.height)];
        label.text = @"长按拖动排序";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
    }
    return self;
}

@end
