//
//  MediaModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MediaModel : NSObject
@property (nonatomic, strong) NSNumber* replyCount;
@property (nonatomic, strong) NSString* mp4Hd_url;
@property (nonatomic, strong) NSString* cover;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* replyBoard;
@property (nonatomic, strong) NSNumber* playCount;
@property (nonatomic, strong) NSString* replyid;
@property (nonatomic, strong) NSString* mp4_url;
@property (nonatomic, strong) NSNumber* length;
@property (nonatomic, strong) NSNumber* playersize;
@property (nonatomic, strong) NSString* m3u8Hd_url;
@property (nonatomic, strong) NSString* m3u8_url;
@property (nonatomic, strong) NSString* ptime;
@property (nonatomic, strong) NSString* vid;

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) NSString* playTiemString;


- (instancetype)initWithDictionary:(NSDictionary *)dic;
+(NSMutableArray *)getMediaModelFromResponse:(NSDictionary *)response;

@end
