//
//  RadioObjectModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property (nonatomic, strong) NSString* commentid;
@property (nonatomic, strong) NSString* ref;
@property (nonatomic, strong) NSString* topicid;
@property (nonatomic, strong) NSString* cover;
@property (nonatomic, strong) NSString* alt;
@property (nonatomic, strong) NSString* url_mp4;
@property (nonatomic, strong) NSString* broadcast;
@property (nonatomic, strong) NSString* commentboard;
@property (nonatomic, strong) NSString* appurl;
@property (nonatomic, strong) NSString* url_m3u8;
@property (nonatomic, strong) NSString* size;


- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
