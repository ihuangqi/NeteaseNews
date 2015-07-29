
//
//  PM2D5Model.m
//  NeteasyNews
//
//  Created by 004 on 15/6/16.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "PM2D5Model.h"

#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]




@implementation PM2D5Model
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    self = [super init];
    if (self) {
        GetPropertyForDictionary(_nbg1);
        GetPropertyForDictionary(_nbg2);
        GetPropertyForDictionary(_aqi);
        GetPropertyForDictionary(_pm2_5);
    }
    return self;
}
@end
