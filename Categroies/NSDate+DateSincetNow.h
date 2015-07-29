//
//  NSDate+DateSincetToday.h
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kDayKey @"Day"
#define kTimeKey @"Time"
#define kHowHourSinceNowKey @"HowHourSinceNowKey"
@interface NSDate (DateSincetNow)
+(NSDictionary *)getStringFromDataString:(NSString *)string dateFormatString:(NSString *)formatterString;
@end
