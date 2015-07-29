//
//  SubTemplateModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]


#import "SubTemplateModel.h"

@implementation SubTemplateModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionaru(_title);
        GetPropertyForDictionaru(_coin);
        GetPropertyForDictionaru(_tag);
        GetPropertyForDictionaru(_money);
        GetPropertyForDictionaru(_image);
        GetPropertyForDictionaru(_url);
        
        _imageURLPath = _image;
        _titleLabeText = _title;
        _subTitleLabelText = _coin;
        _detailURL = _url;
    }
    return self;
}
@end
