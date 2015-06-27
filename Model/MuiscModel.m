//
//  MuiscModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/4.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]

#import "MuiscModel.h"

@implementation MuiscModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_url);
        GetPropertyForDictionary(_imageUrl);
    }
    return self;
}
+(NSString *)getURLString{
    return @"http://music.163.com/api/news/banner/single";
}
+(NSMutableArray *)GetMuiscModel:(NSDictionary *)dictionary{
    NSMutableArray *array = [NSMutableArray new];
    MuiscModel *model = [[MuiscModel alloc] initWithDictionary:dictionary[@"banner"]];
    [array addObject:model];
    return array;
} 
@end
