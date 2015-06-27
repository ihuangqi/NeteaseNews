//
//  CategoryModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/4.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* value;
@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) NSNumber* pageStart;
@property (nonatomic, strong) NSNumber* pageCount;

//@property (nonatomic, strong) NSNumber* isRequest;

//@property (nonatomic, strong) NSNumber* isRequestFaile;

@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* specifyURL;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

+(void)writeToFile;
+(NSMutableArray *)GetAllModel;

@property (nonatomic, assign) BOOL isSelected;

+(void)setSelectedModel:(CategoryModel *)selectedModel;
+(CategoryModel *)selectedModel;

@end
