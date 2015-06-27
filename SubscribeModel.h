//
//  SubscribeModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscribeModel : NSObject
@property (nonatomic, strong) NSMutableArray* bannerlist;
@property (nonatomic, strong) NSMutableArray* recommendlist;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+(SubscribeModel *)getSubscribeModelFromResponse:(id) response;
@end
