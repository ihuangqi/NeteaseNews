//
//  RadioModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//


#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]




#import "RadioModel.h"

@implementation RadioModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_alias);
        GetPropertyForDictionary(_boardid);
        GetPropertyForDictionary(_cid);
        GetPropertyForDictionary(_digest);
        GetPropertyForDictionary(_docid);
        GetPropertyForDictionary(_ename);
        GetPropertyForDictionary(_hasAD);
        GetPropertyForDictionary(_hasCover);
        GetPropertyForDictionary(_hasHead);
        GetPropertyForDictionary(_hasIcon);
        GetPropertyForDictionary(_hasImg);
        GetPropertyForDictionary(_imgsrc);
        GetPropertyForDictionary(_lmodify);
        GetPropertyForDictionary(_order);
        GetPropertyForDictionary(_priority);
        GetPropertyForDictionary(_ptime);
        GetPropertyForDictionary(_replyCount);
        GetPropertyForDictionary(_size);
        GetPropertyForDictionary(_source);
        GetPropertyForDictionary(_subtitle);
        GetPropertyForDictionary(_TAG);
        GetPropertyForDictionary(_TAGS);
        GetPropertyForDictionary(_template);
        GetPropertyForDictionary(_title);
        GetPropertyForDictionary(_tname);
        GetPropertyForDictionary(_url);
        GetPropertyForDictionary(_url_3w);
        GetPropertyForDictionary(_votecount);

    }
    return self;
}
@end
