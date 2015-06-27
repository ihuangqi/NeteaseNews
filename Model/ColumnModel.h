//
//  ColumnModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/9.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnModel : NSObject
@property (nonatomic, strong) NSMutableArray* docs;
@property (nonatomic, strong) NSString* tid;
@property (nonatomic, strong) NSString* source;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
+(NSMutableArray *)getColumnModelArrayFromResponse:(id) response;
@end
