//
//  TemplateModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//


#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]



#import "TemplateModel.h"
#import "SubTemplateModel.h"

@implementation TemplateModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        GetPropertyForDictionaru(_title);
        GetPropertyForDictionaru(_templateCount);
        GetPropertyForDictionaru(_url);
        NSArray *array = GetPropertyForDictionaru(_subTemplate);
        if ([array isKindOfClass:[NSArray class]] && array.count > 0) {
            _subTemplate = [NSMutableArray new];
            for (NSDictionary *childDic in array) {
                [_subTemplate  addObject:[[SubTemplateModel alloc] initWithDictionary:childDic]];
            }
        }
        _titleLabeText = _title;
        _detailURL = _url;
        _subItem = _subTemplate;
    }
    return self;
}

//+(NSMutableArray *)getTemplateModelFromNSArray:(NSArray *)array{
//    if (![array isKindOfClass:[NSArray class]]) {
//        return nil;
//    }
//    NSMutableArray *resultArray = [NSMutableArray new];
//    for (NSDictionary *dic in array) {
//        [resultArray addObject:[[TemplateModel alloc] initWithDictionary:dic]];
//    }
//    return resultArray;
//}
@end
