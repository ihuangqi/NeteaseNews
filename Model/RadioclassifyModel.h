//
//  RadioclassifyModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioclassifyModel : NSObject
@property (nonatomic, strong) NSString* cid;
@property (nonatomic, strong) NSString* cname;

@property (nonatomic, strong) NSMutableArray* tList;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
