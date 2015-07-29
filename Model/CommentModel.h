//
//  CommentModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/6.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define kReplyBoardKey @"ReplyBoard"
#define kdocidKey @"DocID"
#define kCommentViewArrayKey @"CommentView"

#import <Foundation/Foundation.h>
@class CommentView;
@interface CommentModel : NSObject
@property (nonatomic, strong) NSString* timg;
@property (nonatomic, strong) NSString* f;
@property (nonatomic, strong) NSString* rp;
@property (nonatomic, strong) NSString* v;
@property (nonatomic, strong) NSString* u;
@property (nonatomic, strong) NSString* t;
@property (nonatomic, strong) NSString* b;
@property (nonatomic, strong) NSString* fi;
@property (nonatomic, strong) NSString* a;
@property (nonatomic, strong) NSString* p;
@property (nonatomic, strong) NSString* n;
@property (nonatomic, strong) NSString* pi;


+(NSArray *)getCommentModel:(id)response;
+(void)setCommentView:(NSDictionary *)parameter;
@end
