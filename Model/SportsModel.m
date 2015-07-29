//
//  SportsModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/5.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "SportsModel.h"

#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]




@implementation SportsModel
//http://caipiao.163.com/static/news/entrance.htm

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionaru(_visitLogoUrl);
        GetPropertyForDictionaru(_visitName);

        GetPropertyForDictionaru(_leagueName);
        GetPropertyForDictionaru(_score);
        GetPropertyForDictionaru(_startTime);

        GetPropertyForDictionaru(_statusDesc);
        GetPropertyForDictionaru(_hostLogoUrl);
        GetPropertyForDictionaru(_hostName);
        
    }
    return self;
}
+(NSString *)getURLString{
    return @"http://caipiao.163.com/static/news/entrance.htm";
}
+(NSMutableArray *)GetSportModel:(NSDictionary *)dictionary{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dictionary[@"data"]) {
        [array addObject:[[SportsModel alloc] initWithDictionary:dic]];
    }
    return array;
}
@end