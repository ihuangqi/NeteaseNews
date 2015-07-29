//
//  ColumnsModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnsModel : NSObject

@property (nonatomic, strong) NSString* template;
@property (nonatomic, strong) NSString* topicid;
@property (nonatomic, strong) NSString* hasCover;
@property (nonatomic, strong) NSString* alias;
@property (nonatomic, strong) NSString* subnum;
@property (nonatomic, strong) NSString* recommendOrder;
@property (nonatomic, strong) NSString* isNew;
@property (nonatomic, strong) NSString* img;
@property (nonatomic, strong) NSString* isHot;
@property (nonatomic, strong) NSString* hasIcon;
@property (nonatomic, strong) NSString* recommend;
@property (nonatomic, strong) NSString* headLine;
@property (nonatomic, strong) NSString* color;
@property (nonatomic, strong) NSString* bannerOrder;
@property (nonatomic, strong) NSString* tname;
@property (nonatomic, strong) NSString* ename;
@property (nonatomic, strong) NSString* showType;
@property (nonatomic, strong) NSString* tid;
@property (nonatomic, strong) NSString* cid;



- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
