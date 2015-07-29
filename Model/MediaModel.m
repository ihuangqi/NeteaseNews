//
//  MediaModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "MediaModel.h"
#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]

#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]

@implementation MediaModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionaru(_replyCount);

        _mp4Hd_url = dic[@"mp4Hd_url"];
        
        GetPropertyForDictionaru(_cover);
        GetPropertyForDictionaru(_title);
        GetPropertyForDictionaru(_replyBoard);
        GetPropertyForDictionaru(_playCount);
        GetPropertyForDictionaru(_replyid);
        
        _mp4_url = dic[@"mp4_url"];
        
        GetPropertyForDictionaru(_length);
        GetPropertyForDictionaru(_playersize);
        
        _m3u8Hd_url = dic[@"m3u8Hd_url"];
        _m3u8_url = dic[@"m3u8_url"];
        
        GetPropertyForDictionaru(_ptime);
        GetPropertyForDictionaru(_vid);
    }
    return self;
}
+(NSMutableArray *)getMediaModelFromResponse:(id)response{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
//    NSDictionary *responseDictionary = (NSDictionary *)response;
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dic in response[[response allKeys][0]]) {
        MediaModel *model = [[MediaModel alloc] initWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
@end
