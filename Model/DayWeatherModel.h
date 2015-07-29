//
//  DayWeatherModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/16.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayWeatherModel : NSObject
@property (nonatomic, strong) NSString* wind;
@property (nonatomic, strong) NSString* nongli;
@property (nonatomic, strong) NSString* date;
@property (nonatomic, strong) NSString* climate;
@property (nonatomic, strong) NSString* temperature;
@property (nonatomic, strong) NSString* week;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
