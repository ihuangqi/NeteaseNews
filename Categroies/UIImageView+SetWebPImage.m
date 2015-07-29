//
//  UIImageView+setWebPImage.m
//  NeteasyNews
//
//  Created by 004 on 15/6/9.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "UIImageView+SetWebPImage.h"
#import "UIImage+WebP.h"
#import "AFNetworking.h"

@implementation UIImageView (SetWebPImage)
-(void)setWebPImageFromURLString:(NSString *)urlString{
    self.image = nil;
    if (urlString == nil) {
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //NSLog(@"%@",urlString);
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject == nil) {
            return ;
        }
        UIImage* image = [UIImage imageWithWebPData:responseObject];
        self.image = image;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取WebP图像失败");
    }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//        
//        NSHTTPURLResponse *response;
//        NSError *error;
//        
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//        if (data == nil) {
//            return ;
//        }
//        
//        // NSAssert(image, @"WebP解析失败");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
//    });
}
@end
