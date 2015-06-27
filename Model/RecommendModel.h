//
//  RecommendModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject
@property (nonatomic, strong) NSString* TAG;
@property (nonatomic, strong) NSString* TAGS;
@property (nonatomic, strong) NSString* boardid;
@property (nonatomic, strong) NSString* digest;
@property (nonatomic, strong) NSString* docid;
@property (nonatomic, strong) NSString* downTimes;
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* img;
@property (nonatomic, strong) NSString* imgsrc;
@property (nonatomic, strong) NSString* picCount;
@property (nonatomic, strong) NSString* pixel;
@property (nonatomic, strong) NSString* prompt;
@property (nonatomic, strong) NSString* replyCount;
@property (nonatomic, strong) NSString* replyid;
@property (nonatomic, strong) NSString* source;
@property (nonatomic, strong) NSString* template;
@property (nonatomic, strong) NSString* tid;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSNumber* upTimes;
@property (nonatomic, strong) NSMutableArray* imgnewextra;

+(NSMutableArray *)getRecommendModelFromResponse:(id)response;
@end
