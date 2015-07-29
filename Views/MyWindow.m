//
//  MyWindow.m
//  NeteaseNews
//
//  Created by 004 on 15/6/29.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "MyWindow.h"

@implementation MyWindow{
    CAEmitterLayer *mortor;
    CAEmitterCell *rocket;
    NSInteger viewCount;
    BOOL isBegan;
}

- (id)initWithCoder:(NSCoder *)decoder {
    // This covers NIB-loaded windows.
    self = [super initWithCoder:decoder];
    if (self != nil) [self initAnimation];
    return self;
}
- (NSInteger)getCountOfView:(UIView *)view{
    NSInteger count = 0;
    for (UIView *childView in view.subviews) {
        count ++;
        if (childView.subviews.count > 0) {
            if ([childView isKindOfClass:[UIScrollView class]]) {
                count += 40;
            }
            count += [self getCountOfView:childView];
        }
    }
    return count;
}
- (id)initWithFrame:(CGRect)rect {
    // This covers programmatically-created windows.
    self = [super initWithFrame:rect];
    if (self != nil) [self initAnimation];
    return self;
}

-(void)initAnimation{
    mortor = [CAEmitterLayer layer];
    mortor.emitterPosition = CGPointMake(self.window.bounds.size.width/2, self.window.bounds.size.height/2);
    mortor.emitterShape = kCAEmitterLayerCircle;
    mortor.renderMode = kCAEmitterLayerAdditive;
    mortor.birthRate = 0;
    rocket = [CAEmitterCell emitterCell];

    rocket.scale			= 0.6;
    rocket.scaleSpeed		=-0.2;

    rocket.emissionLongitude = M_PI * 0.5;	// sideways to triangle vector
    rocket.emissionLatitude = 0;
    rocket.lifetime = 0.5;
    rocket.birthRate = 10;
    rocket.velocityRange = 50;
    rocket.velocity = 100;

    //    rocket.emissionRange = M_PI/4;
    rocket.redRange = 0.5;
    rocket.greenRange = 0.5;
    rocket.blueRange = 0.5;
    rocket.alphaRange = 0.5;
//    rocket.greenSpeed =-0.1;	// shifting to blue
//    rocket.redSpeed	  =-0.1;
//    rocket.blueSpeed  = -0.1;
    rocket.alphaSpeed =-0.2;

    rocket.contents = (id)[UIImage imageNamed:@"tspark"].CGImage;
    rocket.color = CGColorCreateCopy([UIColor colorWithRed:.5 green:.5 blue:.5 alpha:0.5].CGColor);
    [rocket setName:@"rocket"];

    mortor.emitterSize	= CGSizeMake(50, 0);
    mortor.emitterMode	= kCAEmitterLayerOutline;
    mortor.emitterShape	= kCAEmitterLayerCircle;
    mortor.renderMode	= kCAEmitterLayerBackToFront;

    mortor.emitterCells = [NSArray arrayWithObject:rocket];

    [self.layer addSublayer:mortor];
}

- (void)sendEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    for (UITouch *touch in [allTouches allObjects]) {
        CGPoint point = [touch locationInView:self];

        if (!isBegan) {
            viewCount = [self getCountOfView:self];
        }
        switch (touch.phase) {
            case UITouchPhaseBegan:
            {
                isBegan = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.layer addSublayer:mortor];
                    mortor.emitterPosition = point;
                    NSInteger birthRate = (30 - viewCount/10 / 2 );
                    rocket.birthRate	= birthRate < 10 ? 10: birthRate;
                    rocket.velocity		= 50;
                    mortor.birthRate = 10;
                });
                break;
            }
            case UITouchPhaseMoved:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    mortor.emitterPosition = point;
                    NSInteger birthRate = (20 - viewCount/10 / 2 );
                    rocket.birthRate	= birthRate < 10 ? 5: birthRate;
                    rocket.velocity			= 100;
                });
                break;
            }
            case UITouchPhaseStationary:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    mortor.emitterPosition = point;
                    NSInteger birthRate = (30 - viewCount/10 / 2 );
                    rocket.birthRate	= birthRate < 10 ? 10: birthRate;
                    rocket.velocity		= 50;
                });
                break;
            }
            case UITouchPhaseEnded:
            {
                isBegan = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [mortor setValue:[NSNumber numberWithInteger:0] forKeyPath:@"birthRate"];
                });
                break;
            }
            case UITouchPhaseCancelled:
            {
                isBegan = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [mortor setValue:[NSNumber numberWithInteger:0] forKeyPath:@"birthRate"];
                });
                break;
            }
        }
    }

    [super sendEvent:event];
}

@end
