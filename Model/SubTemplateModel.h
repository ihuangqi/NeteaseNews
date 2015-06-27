//
//  SubTemplateModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvertiseModel.h"

@interface SubTemplateModel : AdvertiseModel
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* coin;
@property (nonatomic, strong) NSString* tag;
@property (nonatomic, strong) NSString* money;
@property (nonatomic, strong) NSString* image;
@property (nonatomic, strong) NSString* url;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
