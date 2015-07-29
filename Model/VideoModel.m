//
//  RadioObjectModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//


#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]




#import "VideoModel.h"

@implementation VideoModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_commentid);
        GetPropertyForDictionary(_ref);
        GetPropertyForDictionary(_topicid);
        GetPropertyForDictionary(_cover);
        GetPropertyForDictionary(_alt);
        GetPropertyForDictionary(_url_mp4);
        GetPropertyForDictionary(_broadcast);
        GetPropertyForDictionary(_commentboard);
        GetPropertyForDictionary(_appurl);

        _url_m3u8 = dic[@"url_m3u8"];

        GetPropertyForDictionary(_size);
    }
    return self;
}
@end
