//
//  ColumnModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/9.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "ColumnModel.h"
#import "NewsModel.h"
@implementation ColumnModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _tid = dic[@"tid"];
        NSArray *array = dic[@"docs"];
        if (array && [array isKindOfClass:[NSArray class]]) {
            _docs = [NSMutableArray new];
            for (NSDictionary *docDic in array) {
                NewsModel *newsModel = [[NewsModel alloc] initWithDictionary:docDic];
                if (_source == nil) {                    
                    if (newsModel.source != nil) {
                        _source = newsModel.source;
                    }
                }
                [_docs addObject:newsModel];
            }
        }
    }
    return self;
}

+(NSMutableArray *)getColumnModelArrayFromResponse:(id) response{
    if(![response isKindOfClass:[NSArray class]])
    {
        return nil;
    }
    NSMutableArray *columnModelArray = [NSMutableArray new];
    for (NSDictionary *dic in response) {
        ColumnModel *columnModel = [[ColumnModel alloc] initWithDictionary:dic];
        [columnModelArray addObject:columnModel];
    }
    return columnModelArray;
}

@end
