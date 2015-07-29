//
//  Network.h
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^NetworkDataCallBack)(id responseObject);
@interface Network : NSObject
+(void)GetDataFromAFNetworkingWithURL:(NSString *)urlString CallBack:(void (^)(id responseObject))blocks;
+(void)PostDataFromAFNetworkingWithURL:(NSString *)urlString parameters:(NSDictionary *)parameter CallBack:(void (^)(id responseObject))callBack;
@end
