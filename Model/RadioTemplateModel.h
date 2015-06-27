//
//  RadioTopModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define kRadioTemplateModelKey @"RadioTemplateModel"


#import <Foundation/Foundation.h>
#import "RadioModel.h"

@interface RadioTemplateModel : NSObject

@property (nonatomic, strong) NSString* alias;
@property (nonatomic, strong) NSNumber* bannerOrder;
@property (nonatomic, strong) NSString* cid;
@property (nonatomic, strong) NSString* color;
@property (nonatomic, strong) NSString* ename;
@property (nonatomic, strong) NSNumber* hasCover;
@property (nonatomic, strong) NSNumber* hasIcon;
@property (nonatomic, assign) NSNumber* headLine;
@property (nonatomic, strong) NSString* img;
@property (nonatomic, strong) NSNumber* isHot;
@property (nonatomic, strong) NSNumber* isNew;
@property (nonatomic, strong) NSNumber* playCount;
@property (nonatomic, strong) NSString* recommend;
@property (nonatomic, strong) NSNumber* recommendOrder;
@property (nonatomic, strong) NSString* showType;
@property (nonatomic, strong) NSString* subnum;
@property (nonatomic, strong) NSString* template;
@property (nonatomic, strong) NSString* tid;
@property (nonatomic, strong) NSString* tname;
@property (nonatomic, strong) NSString* topicid;


@property (nonatomic, strong) RadioModel* radio;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
