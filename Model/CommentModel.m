//
//  CommentModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/6.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]

#import "CommentModel.h"

#import "CommentView.h"
#import "AFNetworking.h"


@implementation CommentModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionaru(_timg);
        GetPropertyForDictionaru(_f);
        GetPropertyForDictionaru(_rp);
        GetPropertyForDictionaru(_v);
        GetPropertyForDictionaru(_u);
        GetPropertyForDictionaru(_t);
        GetPropertyForDictionaru(_b);
        GetPropertyForDictionaru(_fi);
        GetPropertyForDictionaru(_a);
        GetPropertyForDictionaru(_p);
        GetPropertyForDictionaru(_n);
        GetPropertyForDictionaru(_pi);
    }
    return self;
}

+(NSArray *)getCommentModel:(id)response{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray *array = response[@"hotPosts"];
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *modelArray = [NSMutableArray new];
    for (NSDictionary *dic in array) {
        NSDictionary *modelDic = dic[@"1"];
        CommentModel *model = [[CommentModel alloc] initWithDictionary:modelDic];
        [modelArray addObject:model];
    }
    return modelArray;
}
+(void)setCommentView:(NSDictionary *)parameter{
}
@end
