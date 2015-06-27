//
//  SportsModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/5.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "NewsModel.h"

@interface SportsModel : NewsModel
@property (nonatomic, strong) NSString* visitName;
@property (nonatomic, strong) NSString* visitLogoUrl;

@property (nonatomic, strong) NSString* leagueName;
@property (nonatomic, strong) NSString* score;
@property (nonatomic, strong) NSString* statusDesc;
@property (nonatomic, strong) NSString* startTime;

@property (nonatomic, strong) NSString* hostName;
@property (nonatomic, strong) NSString* hostLogoUrl;


+(NSString *)getURLString;
+(NSMutableArray *)GetSportModel:(NSDictionary *)dictionary;
@end
