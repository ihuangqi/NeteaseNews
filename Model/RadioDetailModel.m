//
//  RadioDetailModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//


#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]



#import "RadioDetailModel.h"

@implementation RadioDetailModel
- (instancetype)initWithDictionary:(NSDictionary *)objc
{
    if (![objc isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSDictionary *dic = objc[[objc allKeys][0]];
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_body);
        GetPropertyForDictionary(_users);
        GetPropertyForDictionary(_replyCount);
        GetPropertyForDictionary(_link);
        GetPropertyForDictionary(_votes);
        GetPropertyForDictionary(_img);
        GetPropertyForDictionary(_digest);
        GetPropertyForDictionary(_topiclist_news);
        GetPropertyForDictionary(_topiclist);
        GetPropertyForDictionary(_docid);
        GetPropertyForDictionary(_title);
        GetPropertyForDictionary(_picnews);
        GetPropertyForDictionary(_tid);
        GetPropertyForDictionary(_template);
        GetPropertyForDictionary(_threadVote);
        GetPropertyForDictionary(_relative);
        GetPropertyForDictionary(_threadAgainst);
        GetPropertyForDictionary(_boboList);
        GetPropertyForDictionary(_replyBoard);
        GetPropertyForDictionary(_source);
        GetPropertyForDictionary(_hasNext);
        GetPropertyForDictionary(_voicecomment);
        GetPropertyForDictionary(_apps);
        GetPropertyForDictionary(_ptime);
        NSArray *array = dic[PropertyToString(_video)];
        if (array && [array isKindOfClass:[NSArray class]]) {
            _video = [[RadioObjectModel alloc] initWithDictionary:array[0]];
        }
    }
    return self;
}
@end
