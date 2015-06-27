//
//  ColumnsListModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]


#import "ColumnsListModel.h"
#import "ColumnsModel.h"

@implementation ColumnsListModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionaru(_cid);
        GetPropertyForDictionaru(_cName);
        NSArray *array = GetPropertyForDictionaru(_tList);
        if (array && [array isKindOfClass:[NSArray class]]) {
            _tList = [NSMutableArray new];
            for (NSDictionary *dicList in array) {
                ColumnsModel *model = [[ColumnsModel alloc] initWithDictionary:dicList];
                [_tList addObject:model];
            }
        }
    }
    return self;
}

+(NSMutableArray *)getAllColumnsListModelFromResponse:(id)response{
    if (![response isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dic in response) {
        ColumnsListModel *columnsListModel = [[ColumnsListModel alloc] initWithDictionary:dic];
        [array addObject:columnsListModel];
    }
    return array;
}

+(NSMutableArray *)getRecommendColumnsListModelFromResponse:(id)response{
    if (![response isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dic in response) {
        ColumnsModel *columnsModel = [[ColumnsModel alloc] initWithDictionary:dic];
        [array addObject:columnsModel];
    }
    return array;
}
@end
