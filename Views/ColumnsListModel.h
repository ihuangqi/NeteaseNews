//
//  ColumnsListModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnsListModel : NSObject
@property (nonatomic, strong) NSMutableArray* tList;
@property (nonatomic, strong) NSString* cName;
@property (nonatomic, strong) NSString* cid;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+(NSMutableArray *)getAllColumnsListModelFromResponse:(id)response;
+(NSMutableArray *)getRecommendColumnsListModelFromResponse:(id)response;
@end
