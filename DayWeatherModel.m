//
//  DayWeatherModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/16.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]



#import "DayWeatherModel.h"

@implementation DayWeatherModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_wind);
        GetPropertyForDictionary(_nongli);
        GetPropertyForDictionary(_date);
        GetPropertyForDictionary(_climate);
        GetPropertyForDictionary(_temperature);
        GetPropertyForDictionary(_week);
    }
    return self;
}

@end
