//
//  BannerListModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "BannerListModel.h"
#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]



@implementation BannerListModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        GetPropertyForDictionaru(_imgsrc);
        GetPropertyForDictionaru(_tname);
        GetPropertyForDictionaru(_tid);
    }
    return self;
}

@end
