//
//  RecommendListModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "RecommendListModel.h"

#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]


@implementation RecommendListModel


- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        GetPropertyForDictionaru(_docid);
        GetPropertyForDictionaru(_title);
        GetPropertyForDictionaru(_subnum);
        GetPropertyForDictionaru(_alias);
        GetPropertyForDictionaru(_tname);
        GetPropertyForDictionaru(_ename);
        GetPropertyForDictionaru(_digest);
        GetPropertyForDictionaru(_tid);
        
    }
    return self;
}

-(void)add{
    //http://c.3g.163.com/uc/api/visitor/subs/add
    
    //http://c.m.163.com/nc/topicset/android/v4/subscribe/read/all.html

}
@end
