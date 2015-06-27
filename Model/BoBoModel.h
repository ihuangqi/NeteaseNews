//
//  BoBoModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/4.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntertainmentModel.h"
@interface BoBoModel : NSObject
@property (nonatomic, strong) NSString* anchorCategory;
@property (nonatomic, strong) NSString* sex;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSString* ownerId;
@property (nonatomic, strong) NSString* roomId;
@property (nonatomic, strong) NSString* followsCount;
@property (nonatomic, strong) NSString* avatar;
@property (nonatomic, strong) NSString* cost;
@property (nonatomic, strong) NSString* userNum;
@property (nonatomic, strong) NSString* duration;
@property (nonatomic, strong) NSString* cover;
@property (nonatomic, strong) NSString* liveBegin;
@property (nonatomic, strong) NSString* level;
@property (nonatomic, strong) NSString* nick;
@property (nonatomic, strong) NSString* roomType;
@property (nonatomic, strong) NSString* roomName;
@property (nonatomic, strong) NSString* familyCover;
@property (nonatomic, strong) NSString* familyAvatar;
@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSString* serialVersionUID;
@property (nonatomic, strong) NSString* badge;
@property (nonatomic, strong) NSString* followedCount;
@property (nonatomic, strong) NSString* crowd;
@property (nonatomic, strong) NSString* anchorType;
@property (nonatomic, strong) NSString* live;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+(NSMutableArray *)GetBoBoModel:(NSArray  *)array;
+(NSString *)getURLString;
@end
