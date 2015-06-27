//
//  RecommendModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "RecommendModel.h"

#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]

@implementation RecommendModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        GetPropertyForDictionaru(_TAG);
        GetPropertyForDictionaru(_TAGS);
        GetPropertyForDictionaru(_boardid);
        GetPropertyForDictionaru(_digest);
        GetPropertyForDictionaru(_docid);
        GetPropertyForDictionaru(_downTimes);
        GetPropertyForDictionaru(_id);
        GetPropertyForDictionaru(_img);
        GetPropertyForDictionaru(_imgsrc);
        GetPropertyForDictionaru(_picCount);
        GetPropertyForDictionaru(_pixel);
        GetPropertyForDictionaru(_prompt);
        GetPropertyForDictionaru(_replyCount);
        GetPropertyForDictionaru(_replyid);
        GetPropertyForDictionaru(_source);
        GetPropertyForDictionaru(_template);
        GetPropertyForDictionaru(_tid);
        GetPropertyForDictionaru(_title);
        GetPropertyForDictionaru(_upTimes);
        
        if ([_digest hasPrefix:@"\n"] || [_digest hasPrefix:@"\t"]) {
            int i;
            for (i = 0; i < _digest.length; i ++) {
                if ([_digest characterAtIndex:i] != '\n' && [_digest  characterAtIndex:i] != '\t') {
                    break;
                }
            }
            _digest = [_digest substringFromIndex:i];
        }
        
        _imgnewextra = [NSMutableArray new];
        for (NSDictionary *imageDictionary in dic[PropertyToString(_imgnewextra)]) {
            [_imgnewextra addObject:imageDictionary[@"imgsrc"]];
        }
    }
    return self;
}

+(NSMutableArray *)getRecommendModelFromResponse:(id)response{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dic in response[[response allKeys][0]]) {
        RecommendModel *model = [[RecommendModel alloc] initWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
@end
