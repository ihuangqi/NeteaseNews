//
//  UILabel+setTimeText.m
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "UILabel+setTimeText.h"
#import "NSDate+DateSincetNow.h"
@implementation UILabel (setTimeText) 
-(void)setTimeText:(NSString *)string DateFormatString:(NSString *)dateFormatString{
    self.text = nil;
    if (string == nil) {
        return;
    }
    NSDictionary *dic =  [NSDate getStringFromDataString:string dateFormatString:dateFormatString];
    NSString* howHourSinceNow = dic[kHowHourSinceNowKey];
    self.text = howHourSinceNow;
}
@end
