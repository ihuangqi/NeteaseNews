//
//  Activity.h
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvertiseModel.h"

@interface Activity : AdvertiseModel
@property (nonatomic, strong) NSString       * activityCount;
@property (nonatomic, strong) NSString       * title;
@property (nonatomic, strong) NSMutableArray * subActivity;
@property (nonatomic, strong) NSString       * url;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
