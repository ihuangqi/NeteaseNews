//
//  ImgModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/15.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "ImgModel.h"

#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]




@implementation ImgModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
         GetPropertyForDictionary(_ref);
         GetPropertyForDictionary(_pixel);
         GetPropertyForDictionary(_alt);
         GetPropertyForDictionary(_src);
    }
    return self;
}
@end
