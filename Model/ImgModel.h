//
//  ImgModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/15.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgModel : NSObject
@property (nonatomic, strong) NSString* ref;
@property (nonatomic, strong) NSString* pixel;
@property (nonatomic, strong) NSString* alt;
@property (nonatomic, strong) NSString* src;


- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
