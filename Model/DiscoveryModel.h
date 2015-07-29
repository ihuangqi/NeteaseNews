//
//  DiscoveryModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KRecommendKey @"Recommend"
#define KBannerKey @"Banner"


#import "Activity.h"
#import "TemplateModel.h"

@interface DiscoveryModel : NSObject

@property (nonatomic, strong) TemplateModel* template;
@property (nonatomic, strong) Activity* activity;
@property (nonatomic, strong) NSMutableArray* recommend;
@property (nonatomic, strong) NSMutableArray* banner;
@property (nonatomic, strong) NSMutableDictionary* recommendAndBannerDic;


- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
