//
//  UIView+MaskView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/24.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "UIView+MaskView.h"

@implementation UIView (MaskView)

- (void)dwMakeBottomRoundCornerWithRadius:(UIView *)view
{

    CGRect frame = [self convertRect:view.frame fromView:self.superview];
    CGRect rect = CGRectIntersection(self.frame,frame);

//    CGSize size = self.frame.size;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor greenColor] CGColor]];

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x+rect.size.width, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
    CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y+rect.size.height);
    
    CGPathCloseSubpath(path);
    
    [shapeLayer setPath:path];
    
    
    CFRelease(path);
    self.layer.mask = shapeLayer;//layer的mask，顾名思义，是种位掩蔽，在shapeLayer的填充区域中，alpha值不为零的部分，self会被绘制；alpha值为零的部分，self不会被绘制
}
@end
