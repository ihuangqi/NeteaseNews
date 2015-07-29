//
//  RadioclassifyModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]



#import "RadioclassifyModel.h"
#import "RadioTemplateModel.h"

@implementation RadioclassifyModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_cid);
        GetPropertyForDictionary(_cname);

        NSArray *array = dic[PropertyToString(_tList)];
        if (array && [array isKindOfClass:[NSArray class]]) {
            _tList = [NSMutableArray new];
            for (NSDictionary *subDic in array) {
                RadioTemplateModel *model = [[RadioTemplateModel alloc] initWithDictionary:subDic];
                [_tList addObject:model];
            }
        }

    }
    return self;
}
@end
