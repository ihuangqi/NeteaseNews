//
//  SubActivity.m
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]



#import "SubActivity.h"


@implementation SubActivity
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_icon);
        GetPropertyForDictionary(_title);
        GetPropertyForDictionary(__description);
        GetPropertyForDictionary(_url);
        
        _imageURLPath = _icon;
        _titleLabeText = _title;
        
        _detailURL = _url;
    }
    return self;
}
@end
