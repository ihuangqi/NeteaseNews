//
//  SubscribeModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "SubscribeModel.h"
#import "BannerListModel.h"
#import "RecommendListModel.h"

@implementation SubscribeModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _bannerlist = [NSMutableArray new];
        for (NSDictionary *bannerDic in dic[@"bannerlist"]) {
            [_bannerlist addObject:[[BannerListModel alloc] initWithDictionary:bannerDic] ];
        }
        _recommendlist = [NSMutableArray new];
        for (NSDictionary *recommendDic in dic[@"recommendlist"]) {
            [_recommendlist addObject:[[RecommendListModel alloc] initWithDictionary:recommendDic]];
        }
    }
    return self;
}
+(SubscribeModel *)getSubscribeModelFromResponse:(id) response{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [[SubscribeModel alloc] initWithDictionary:response];
}
@end
