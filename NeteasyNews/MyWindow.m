//
//  MyWindow.m
//  NeteaseNews
//
//  Created by 004 on 15/6/29.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "MyWindow.h"

@implementation MyWindow
{
    CAEmitterLayer *mortor;
    CAEmitterCell *rocket;
}

- (id)initWithCoder:(NSCoder *)decoder {
    // This covers NIB-loaded windows.
    self = [super initWithCoder:decoder];
    if (self != nil) [self initAnimation];
    return self;
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
    rocket.lifetime = 1;
    rocket.birthRate = 10;
    rocket.velocityRange = 50;
    rocket.velocity = 100;

    //    rocket.emissionRange = M_PI/4;
    rocket.redRange = 0.4;
    rocket.greenRange = 0.4;
    rocket.blueRange = 0.4;
    rocket.alphaRange = 0.4;
    rocket.greenSpeed =-0.1;	// shifting to blue
    rocket.redSpeed	  =-0.1;
    rocket.blueSpeed  = -0.1;
    rocket.alphaSpeed =-0.1;

    rocket.contents = (id)[UIImage imageNamed:@"tspark"].CGImage;
    rocket.color = CGColorCreateCopy([UIColor colorWithRed:.6 green:.6 blue:.6 alpha:0.6].CGColor);
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
        switch (touch.phase) {
            case UITouchPhaseBegan:
            {

                [self.layer addSublayer:mortor];


                mortor.emitterPosition = point;
                rocket.birthRate	= 30;			// every triangle creates 20
                rocket.velocity		= 50;

                mortor.birthRate = 10;
                break;
            }
            case UITouchPhaseMoved:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    mortor.emitterPosition = point;
                    rocket.birthRate		= 20;			// every triangle creates 20
                    rocket.velocity			= 100;
                });
                break;
            }
            case UITouchPhaseStationary:
            {
                mortor.emitterPosition = point;
                rocket.birthRate	= 30;			// every triangle creates 20
                rocket.velocity		= 50;

                break;
            }
            case UITouchPhaseEnded:
            {
                [mortor setValue:[NSNumber numberWithInteger:0] forKeyPath:@"birthRate"];
                break;
            }
            case UITouchPhaseCancelled:
            {
                [mortor setValue:[NSNumber numberWithInteger:0] forKeyPath:@"birthRate"];
                break;
            }
        }
    }

    [super sendEvent:event];
}

@end
