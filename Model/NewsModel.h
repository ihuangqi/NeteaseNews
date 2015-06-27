//
//  NewsModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//

enum ShowLocation{
    ShowLocationNone = 0,
    ShowLocationLeftTop,
    ShowLocationLeftButtom,
    ShowLocationRightTop,
    ShowLocationRightButtom
};
#import <Foundation/Foundation.h>
#import "CategoryModel.h"

@interface NewsModel : NSObject
@property (nonatomic, strong) NSString* hasCover;
@property (nonatomic, strong) NSString* hasHead;
@property (nonatomic, strong) NSString* replyCount;
@property (nonatomic, strong) NSString* hasImg;
@property (nonatomic, strong) NSString* digest;
@property (nonatomic, strong) NSString* hasIcon;
@property (nonatomic, strong) NSString* docid;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* order;
@property (nonatomic, strong) NSString* priority;
@property (nonatomic, strong) NSString* lmodify;
@property (nonatomic, strong) NSString* boardid;
@property (nonatomic, strong) NSString* url_3w;
@property (nonatomic, strong) NSString* template;
@property (nonatomic, strong) NSString* votecount;
//新闻放置区域
@property (nonatomic, strong) NSString* alias;
@property (nonatomic, strong) NSString* cid;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* hasAD;
@property (nonatomic, strong) NSString* source;
@property (nonatomic, strong) NSString* subtitle;
@property (nonatomic, strong) NSString* imgsrc;
@property (nonatomic, strong) NSString* tname;
@property (nonatomic, strong) NSString* ename;
@property (nonatomic, strong) NSString* ptime;
@property (nonatomic, strong) NSString* TAG;

@property (nonatomic, assign) BOOL isShowDigest;
@property (nonatomic, assign) BOOL isShowSource;
@property (nonatomic, assign) BOOL isShowPeplyCount;
@property (nonatomic, assign) BOOL isShowNewPreadButton;

@property (nonatomic, strong) CategoryModel* categoryModel;

@property (nonatomic, strong) NSMutableArray* imgextra;

@property (nonatomic, assign) enum ShowLocation showLoactionOfTag;
@property (nonatomic, assign) enum ShowLocation showLoactionOfreplyCount;


- (instancetype)initWithDictionary:(NSDictionary *)dic;


+(NSMutableArray *)getNewsModelArrayFromResponse:(id) response;

@end
