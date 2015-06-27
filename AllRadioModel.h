//
//  RadioModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadioTemplateModel.h"

@interface AllRadioModel : NSObject
@property (nonatomic, strong) NSMutableArray* cList;
@property (nonatomic, strong) RadioTemplateModel* top;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
