//
//  TemplateModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvertiseModel.h"

@interface TemplateModel : AdvertiseModel
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSNumber* templateCount;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSMutableArray* subTemplate;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
//+(NSMutableArray *)getTemplateModelFromNSArray:(NSArray *)array;
@end
