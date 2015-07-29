//
//  Paint.m
//  NeteaseNews
//
//  Created by 004 on 15/7/1.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "Paint.h"

@implementation Paint
-(void)viewDidLoad{
    [super viewDidLoad];

    //开始图像绘图
    UIGraphicsBeginImageContext(self.view.bounds.size);
    //获取当前CGContextRef
    CGContextRef gc = UIGraphicsGetCurrentContext();

    //创建用于转移坐标的Transform，这样我们不用按照实际显示做坐标计算
    CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 50);
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    //左眼
    CGPathAddEllipseInRect(path, &transform, CGRectMake(0, 0, 20, 20));
    //右眼
    CGPathAddEllipseInRect(path, &transform, CGRectMake(80, 0, 20, 20));
    //笑
    CGPathMoveToPoint(path, &transform, 100, 50);
    CGPathAddArc(path, &transform, 50, 50, 50, 0, M_PI, NO);
    //将CGMutablePathRef添加到当前Context内
    CGContextAddPath(gc, path);
    //设置绘图属性
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(gc, 2);
    //执行绘画
    CGContextStrokePath(gc);

    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self.view addSubview:imgView];
}
@end
