//
//  SubActivity.h
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvertiseModel.h"

@interface SubActivity : AdvertiseModel
@property (nonatomic, strong) NSString* icon;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* _description;
@property (nonatomic, strong) NSString* url;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
