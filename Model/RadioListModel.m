//
//  RadioListModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//


#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]



#import "RadioListModel.h"

@implementation RadioListModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{

    self = [super init];
    if (self) {
        GetPropertyForDictionary(_hasCover);
        GetPropertyForDictionary(_hasHead);
        GetPropertyForDictionary(_replyCount);
        GetPropertyForDictionary(_hasImg);
        GetPropertyForDictionary(_digest);
        GetPropertyForDictionary(_hasIcon);
        GetPropertyForDictionary(_docid);
        GetPropertyForDictionary(_title);
        GetPropertyForDictionary(_TAGS);
        GetPropertyForDictionary(_order);
        GetPropertyForDictionary(_priority);
        GetPropertyForDictionary(_lmodify);
        GetPropertyForDictionary(_boardid);
        GetPropertyForDictionary(_TAG);

        _url_3w = dic[@"url_3w"];

        GetPropertyForDictionary(_template);
        GetPropertyForDictionary(_votecount);
        GetPropertyForDictionary(_alias);
        GetPropertyForDictionary(_cid);
        GetPropertyForDictionary(_url);
        GetPropertyForDictionary(_size);
        GetPropertyForDictionary(_hasAD);
        GetPropertyForDictionary(_source);
        GetPropertyForDictionary(_tname);
        GetPropertyForDictionary(_ename);
        GetPropertyForDictionary(_imgsrc);
        GetPropertyForDictionary(_subtitle);
        GetPropertyForDictionary(_ptime);

    }
    return self;
}

+(NSMutableArray *)getRadioListModeArrayFromResponse:(id)response{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dic in response[[response allKeys][0]]) {
        RadioListModel *model = [[RadioListModel alloc] initWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
@end
