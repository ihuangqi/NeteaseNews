//
//  RadioModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioModel : NSObject
@property (nonatomic, strong) NSString* alias;
@property (nonatomic, strong) NSString* boardid;
@property (nonatomic, strong) NSString* cid;
@property (nonatomic, strong) NSString* digest;
@property (nonatomic, strong) NSString* docid;
@property (nonatomic, strong) NSString* ename;
@property (nonatomic, strong) NSNumber* hasAD;
@property (nonatomic, strong) NSNumber* hasCover;
@property (nonatomic, strong) NSNumber* hasHead;
@property (nonatomic, strong) NSString* hasIcon;
@property (nonatomic, strong) NSNumber* hasImg;
@property (nonatomic, strong) NSString* imgsrc;
@property (nonatomic, strong) NSString* lmodify;
@property (nonatomic, strong) NSNumber* order;
@property (nonatomic, strong) NSNumber* priority;
@property (nonatomic, strong) NSString* ptime;
@property (nonatomic, strong) NSNumber* replyCount;
@property (nonatomic, strong) NSString* size;
@property (nonatomic, strong) NSString* source;
@property (nonatomic, strong) NSString* subtitle;
@property (nonatomic, strong) NSString* TAG;
@property (nonatomic, strong) NSString* TAGS;
@property (nonatomic, strong) NSString* template;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* tname;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* url_3w;
@property (nonatomic, strong) NSString* votecount;



- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
