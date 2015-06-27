//
//  WeatherModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/16.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]



#import "WeatherModel.h"

@implementation WeatherModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_dt);

        _rt_temperature = dic[@"rt_temperature"];

        _pm2d5 = [[PM2D5Model alloc] initWithDictionary:dic[@"pm2d5"]];

        NSArray *array = dic[@"广东|深圳"];
        if (array.count && [array isKindOfClass:[NSArray class]]) {
            _dayWeatherModelList = [NSMutableArray new];
            for (NSDictionary *childDic in array) {
                 [_dayWeatherModelList addObject:[[DayWeatherModel alloc] initWithDictionary:childDic]];
            }
        }
    }
    return self;
}
@end
