//
//  MuiscModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/4.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntertainmentModel.h"
@interface MuiscModel : EntertainmentModel
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* imageUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+(NSMutableArray *)GetMuiscModel:(NSDictionary *)dictionary;
+(NSString *)getURLString;
@end
