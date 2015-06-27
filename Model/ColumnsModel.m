//
//  ColumnsModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]
#import "ColumnsModel.h"

@implementation ColumnsModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {

        GetPropertyForDictionaru(_template);
        GetPropertyForDictionaru(_topicid);
        GetPropertyForDictionaru(_hasCover);
        GetPropertyForDictionaru(_alias);
        GetPropertyForDictionaru(_subnum);
        GetPropertyForDictionaru(_recommendOrder);
        GetPropertyForDictionaru(_isNew);
        GetPropertyForDictionaru(_img);
        GetPropertyForDictionaru(_isHot);
        GetPropertyForDictionaru(_hasIcon);
        GetPropertyForDictionaru(_recommend);
        GetPropertyForDictionaru(_headLine);
        GetPropertyForDictionaru(_color);
        GetPropertyForDictionaru(_bannerOrder);
        GetPropertyForDictionaru(_tname);
        GetPropertyForDictionaru(_ename);
        GetPropertyForDictionaru(_showType);
        GetPropertyForDictionaru(_tid);

    }
    return self;
}

+(void)add{
    NSDictionary *dic;
    //航运界
    //http://c.3g.163.com/uc/api/visitor/subs/add
    dic = @{@"data":@"439ONmZd7w2vdv1tskvFCKqaReO2BjWudNRHSDIeJES6HkgJhNLNc1eqC1WaCRZIpdPQrb01kupBvorL9LPTwQ%3D%3D"};
    
    //费事考考察团
    //http://c.3g.163.com/uc/api/visitor/subs/add
    dic = @{@"data":@"439ONmZd7w2vdv1tskvFCKqaReO2BjWudNRHSDIeJET334OQ2MkY7NirOi4FWu9u2uhSPl00uStcPXdxTyiqUQ=="};
    
    

}
@end
