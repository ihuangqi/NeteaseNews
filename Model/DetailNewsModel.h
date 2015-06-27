//
//  DetailNewsModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/6.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define kDetilViewKey @"DetilView"
#define kdocidKey @"DocID"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "VideoModel.h"
#import "ImgModel.h"

@interface DetailNewsModel : NSObject
@property (nonatomic, strong) NSString         * body;
@property (nonatomic, strong) NSMutableArray   * users;
@property (nonatomic, strong) NSNumber         * replyCount;
@property (nonatomic, strong) NSMutableArray   * link;
@property (nonatomic, strong) NSMutableArray   * votes;
@property (nonatomic, strong) NSMutableArray   * img;
@property (nonatomic, strong) NSString         * digest;
@property (nonatomic, strong) NSMutableArray   * topiclist_news;
@property (nonatomic, strong) NSMutableArray   * topiclist;
@property (nonatomic, strong) NSString         * docid;
@property (nonatomic, strong) NSString         * title;
@property (nonatomic, strong) NSString         * picnews;
@property (nonatomic, strong) NSString         * tid;
@property (nonatomic, strong) NSString         * template;
@property (nonatomic, strong) NSString         * threadVote;
@property (nonatomic, strong) NSMutableArray   * relative;
@property (nonatomic, strong) NSString         * threadAgainst;
@property (nonatomic, strong) NSMutableArray   * boboList;
@property (nonatomic, strong) NSString         * replyBoard;
@property (nonatomic, strong) NSString         * source;
@property (nonatomic, strong) NSString         * hasNext;
@property (nonatomic, strong) NSString         * voicecomment;
@property (nonatomic, strong) NSMutableArray   * apps;
@property (nonatomic, strong) NSString         * ptime;

@property (nonatomic, strong) NSMutableArray * video;

+(NSArray *)getDetailNewsModel:(id)response;
@end
