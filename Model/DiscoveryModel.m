//
//  DiscoveryModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]

#import "DiscoveryModel.h"




#import "RecommendDiscoveryModel.h"
#import "BannerDiscoeryModel.h"


@implementation DiscoveryModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        
         _recommend = [RecommendDiscoveryModel getRecommendDiscoveryModelFromNSArray:dic[PropertyToString(_recommend)]] ; 
         _banner = [BannerDiscoeryModel getBannerDiscoeryModelFromNSArray:dic[PropertyToString(_banner)]]; 
        NSArray *array;
        array = dic[PropertyToString(_template)];
        if ([array isKindOfClass:[NSArray class]] && array.count > 0) {
            _template = [[TemplateModel alloc] initWithDictionary:array[0]];
        }
        array = dic[PropertyToString(_activity)];
        if ([array isKindOfClass:[NSArray class]] && array.count > 0) {
            _activity = [[Activity alloc] initWithDictionary:array[0]];
        }
        if (_recommend.count > 0 || _banner.count > 0) {
            _recommendAndBannerDic = [NSMutableDictionary new];
            if (_recommend.count > 0) {
                [_recommendAndBannerDic setObject:_recommend forKeyedSubscript:KRecommendKey];
            }
            if (_banner.count > 0) {
                [_recommendAndBannerDic setObject:_banner forKeyedSubscript:KBannerKey];
            }
        }
    }
    return self;
}

@end
