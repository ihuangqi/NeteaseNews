//
//  PM2D5Model.h
//  NeteasyNews
//
//  Created by 004 on 15/6/16.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PM2D5Model : NSObject
@property (nonatomic, strong) NSString* nbg1;
@property (nonatomic, strong) NSString* nbg2;
@property (nonatomic, strong) NSString* aqi;
@property (nonatomic, strong) NSString* pm2_5;


- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
