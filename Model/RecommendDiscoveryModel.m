//
//  RecommendDiscoveryModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]

#import "RecommendDiscoveryModel.h"

@implementation RecommendDiscoveryModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_icon);
        GetPropertyForDictionary(_title);
        GetPropertyForDictionary(__description);
        GetPropertyForDictionary(_disappear);
        GetPropertyForDictionary(_url);
    }
    return self;
}
+(NSMutableArray *)getRecommendDiscoveryModelFromNSArray:(NSArray *)array{
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *resultArray = [NSMutableArray new];
    for (NSDictionary *dic in array) {
        [resultArray addObject:[[RecommendDiscoveryModel alloc] initWithDictionary:dic]];
    }
    return resultArray;
}
@end
