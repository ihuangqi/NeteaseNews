//
//  Network.m
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "Network.h"
#import "AFNetworking.h"
#import "UIView+ToastView.h"
@interface Network()<NSURLConnectionDataDelegate>

@end
@implementation Network
static bool isUnConnected;
+(void)GetDataFromAFNetworkingWithURL:(NSString *)urlString CallBack:(void (^)(id responseObject))callBack{

//    if (isUnConnected) {
//        [self isConnected];
//        if (isUnConnected) {
//            callBack(nil);
//            [UIView showToaseViewWithText:@"网络连接不可用" Time:3];
//        }
//    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.requestSerializer.timeoutInterval = 5;

    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        callBack(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
//        [self isConnected];
//        if(isUnConnected){
//            [UIView showToaseViewWithText:@"网络连接不可用" Time:3];
//        }
        callBack(nil);
    }];
}
+(void)PostDataFromAFNetworkingWithURL:(NSString *)urlString parameters:(NSDictionary *)parameter CallBack:(void (^)(id responseObject))callBack{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        callBack(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
//        [self isConnected];
        callBack(nil);
    }];
}
+(void)isConnected{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    NSURLResponse *response = [NSURLResponse alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]] MIMEType:<#(NSString *)#> expectedContentLength:<#(NSInteger)#> textEncodingName:<#(NSString *)#>];
    NSURLResponse *response = nil;
    NSError *error = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (response) {
        NSLog(@"response = %@",response);
        isUnConnected = NO;
    }
    if (error) {
        NSLog(@"error = %@",error);
        if (error.code == -1009) {
            isUnConnected = YES;
        }
    }

}
+(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
    [connection cancel];
    if (error.code == -1009) {
        isUnConnected = YES;
    }

}
+(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
    isUnConnected = NO;
    [connection cancel];
}

@end
