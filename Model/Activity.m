//
//  Activity.m
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]



#import "Activity.h"
#import "SubActivity.h"

@implementation Activity

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_activityCount);
        GetPropertyForDictionary(_title);
        GetPropertyForDictionary(_url);
        
        NSArray *array = GetPropertyForDictionary(_subActivity);
        if (array && [array isKindOfClass:[NSArray class]]) {
            _subActivity = [NSMutableArray new];
            for (NSDictionary *subDic in array) {
                [_subActivity addObject:[[SubActivity alloc] initWithDictionary:subDic]];
            }
        }
        _titleLabeText = _title;
        _detailURL = _url;
        _subItem = _subActivity;
    }
    return self;
}


@end
