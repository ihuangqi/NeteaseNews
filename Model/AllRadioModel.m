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


#import "AllRadioModel.h"
#import "RadioclassifyModel.h"

@implementation AllRadioModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        NSArray *array;
        array = dic[PropertyToString(_top)];
        if (array && [array isKindOfClass:[NSArray class]]) {
            _top = [[RadioTemplateModel alloc] initWithDictionary:array[0]];
        }
        array = dic[PropertyToString(_cList)];
        if (array && [array isKindOfClass:[NSArray class]]) {
            _cList = [NSMutableArray new];
            for (NSDictionary *subDic in array) {
                RadioclassifyModel *model = [[RadioclassifyModel alloc] initWithDictionary:subDic];
                [_cList addObject:model];
            }
        }
    }
    return self;
}


@end
