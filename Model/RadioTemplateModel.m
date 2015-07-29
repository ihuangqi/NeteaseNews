//
//  RadioTopModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]




#import "RadioTemplateModel.h"

@implementation RadioTemplateModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_alias);
        GetPropertyForDictionary(_bannerOrder);
        GetPropertyForDictionary(_cid);
        GetPropertyForDictionary(_color);
        GetPropertyForDictionary(_ename);
        GetPropertyForDictionary(_hasCover);
        GetPropertyForDictionary(_hasIcon);
        GetPropertyForDictionary(_headLine);
        GetPropertyForDictionary(_img);
        GetPropertyForDictionary(_isHot);
        GetPropertyForDictionary(_isNew);
        GetPropertyForDictionary(_playCount);
        GetPropertyForDictionary(_recommend);
        GetPropertyForDictionary(_recommendOrder);
        GetPropertyForDictionary(_showType);
        GetPropertyForDictionary(_subnum);
        GetPropertyForDictionary(_template);
        GetPropertyForDictionary(_tid);
        GetPropertyForDictionary(_tname);
        GetPropertyForDictionary(_topicid);

        _radio = [[RadioModel alloc] initWithDictionary:dic[PropertyToString(radio)]];

    }
    return self;
}

@end
