//
//  UIColor+ConvertToUIImage.m
//  NeteasyNews
//
//  Created by 004 on 15/6/24.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "UIImage+ConvertFromUIImage.h"

@implementation UIImage (ConvertToUIImage)
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
