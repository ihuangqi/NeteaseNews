//
//  WeatherModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/16.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DayWeatherModel.h"
#import "PM2D5Model.h"

@interface WeatherModel : NSObject
@property (nonatomic, strong) NSString        * dt;
@property (nonatomic, strong) NSNumber        * rt_temperature;
@property (nonatomic, strong) NSMutableArray * dayWeatherModelList;
@property (nonatomic, strong) PM2D5Model      * pm2d5;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
