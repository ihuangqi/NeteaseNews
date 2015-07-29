//
//  RecommendListModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "SubscribeModel.h"

@interface RecommendListModel : SubscribeModel


@property (nonatomic, strong) NSString* docid;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* subnum;
@property (nonatomic, strong) NSString* alias;
@property (nonatomic, strong) NSString* tname;
@property (nonatomic, strong) NSString* ename;
@property (nonatomic, strong) NSString* digest;
@property (nonatomic, strong) NSString* tid;



@end
