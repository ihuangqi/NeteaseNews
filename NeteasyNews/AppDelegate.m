//
//  AppDelegate.m
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define kDefanltBackgroundColor [UIColor colorWithRed:0.957 green:0.953 blue:0.953 alpha:1.000]
#import "AppDelegate.h"
#import "NewsViewController.h"
#import "DetailViewController.h"
#import "MediaViewController.h"
#import "UIImage+ScaleToSize.h"
#import "ReadViewController.h"
#import "DiscoveryViewController.h"
#import "AFNetworkReachabilityManager.h"
#include <math.h>
@interface AppDelegate (){
   BOOL isStopAnimation;
    CAEmitterLayer *mortor;
    CAEmitterCell *rocket;

    CGPoint beganPoint;
}
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"Setting"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:@"StartAnimation.plist"];

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    if (dic) {
        if([dic[@"StartAnimation"] boolValue]== NO){
            isStopAnimation = YES;
            [self initViewController];

            return YES;
        }
    }
    dic = @{@"StartAnimation":@(NO)};
    [dic writeToFile:path atomically:NO];
    [self startUpAnimate];
    return YES;
}
-(void)startUpAnimate{
    UIView *view=[[UINib nibWithNibName:@"StartUp" bundle:nil] instantiateWithOwner:self options:nil][0];
    view.frame = self.window.frame;
    view.tag = 10;

    [self.window addSubview:view];
    [self.window bringSubviewToFront:view];


    NSMutableArray *imageArray = [NSMutableArray new];
    for (int i = 1;i <= 7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"biz_ad_new_version1_img%d.jpg",i]];
        [imageArray addObject:image];
    }
    _backgroundImage.opaque = YES;
    _backgroundImage.image = imageArray[0];
    _backgroundImage.alpha = 0;

    [self performSelector:@selector(startAnimateWithArray:) withObject:imageArray afterDelay:1];
}

-(void)startAnimateWithArray:(NSArray *)array{
    static int i = 0;
    if (isStopAnimation) return;
    _backgroundImage.image = array[i];
    [UIView animateWithDuration:3 animations:^{
        _backgroundImage.alpha = 1;
    } completion:^(BOOL finished) {
        if (isStopAnimation) return;
        [UIView animateWithDuration:2 animations:^{
            _backgroundImage.alpha = 0;
            _backgroundImage.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
            if (isStopAnimation) return;
            i = (i+1) % 7;
            _backgroundImage.transform = CGAffineTransformIdentity;
            [self startAnimateWithArray:array];
        }];
    }];
}

- (IBAction)startButtonClick:(id)sender {
    isStopAnimation = YES;
    UIView *view = [self.window viewWithTag:10];
    [view removeFromSuperview];
    [self initViewController];
}

-(void)initViewController{

    NewsViewController *newsVC = [[NewsViewController alloc] init];
    UINavigationController *newsNC = [[UINavigationController alloc] initWithRootViewController:newsVC];
    newsNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻"
                                                      image:[[[UIImage imageNamed:@"biz_navigation_tab_news"] scaleToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[[[UIImage imageNamed:@"biz_navigation_tab_news_selected"]  scaleToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];



    ReadViewController *readVC = [[ReadViewController alloc] init];
    readVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"阅读"
                                                      image:[[[UIImage imageNamed:@"biz_navigation_tab_read"]  scaleToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[[[UIImage imageNamed:@"biz_navigation_tab_read_selected"]  scaleToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];


    MediaViewController *mediaVC = [[MediaViewController alloc] init];
    mediaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视听"
                                                       image:[[[UIImage imageNamed:@"biz_navigation_tab_va"]  scaleToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                               selectedImage:[[[UIImage imageNamed:@"biz_navigation_tab_va_selected"]  scaleToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];



    DiscoveryViewController *discoveryVC = [[DiscoveryViewController alloc] init];
    discoveryVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
                                                           image:[[[UIImage imageNamed:@"biz_navigation_tab_discovery"]  scaleToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                   selectedImage:[[[UIImage imageNamed:@"biz_navigation_tab_discovery_selected"]  scaleToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];


    UIViewController *meVC = [[UIViewController alloc] init];
    meVC.view.backgroundColor = [UIColor blackColor];
    meVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我"
                                                    image:[[[UIImage imageNamed:@"biz_navigation_tab_pc"]  scaleToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                            selectedImage:[[[UIImage imageNamed:@"biz_navigation_tab_pc_selected"]  scaleToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];


    UITabBarController *tabBarC = [[UITabBarController alloc] init];
    tabBarC.viewControllers= @[newsNC,readVC,mediaVC,discoveryVC,meVC];

    tabBarC.tabBar.backgroundColor = kDefanltBackgroundColor;
    tabBarC.selectedIndex = 0;

    self.window.rootViewController = tabBarC;

    UIView *view=[[UINib nibWithNibName:@"StartUp" bundle:nil] instantiateWithOwner:self options:nil][1];
    view.frame = [UIScreen mainScreen].bounds;
    [self.window addSubview:view];
    [self.window bringSubviewToFront:view];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:3];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [UIView animateWithDuration:0.5 animations:^{
//                view.transform = CGAffineTransformMakeScale(0.01, 0.01);
//                view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
//            } completion:^(BOOL finished) {
//                [view removeFromSuperview];
//            }];
            NSArray *array = @[@"cameraIris",@"cube",@"fade",@"moveIn",@"oglFlip",@"pageCurl",@"push",@"reveal",@"rippleEffect",@"suckEffect"];
            CATransition *transition = [[CATransition alloc] init];
            transition.duration = 1;
            transition.type = array[arc4random()%array.count];
//            transition.type = @"pageUnCurl";
            view.backgroundColor = [UIColor clearColor];
            [view.subviews[0] removeFromSuperview];
            [view.layer addAnimation:transition forKey:nil];
            dispatch_async(dispatch_queue_create("HuangQi", DISPATCH_QUEUE_SERIAL), ^{
                [NSThread sleepForTimeInterval:1];
                [view removeFromSuperview];
            });
        });
    });
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    mortor = [CAEmitterLayer layer];
    mortor.emitterPosition = CGPointMake(self.window.bounds.size.width/2, self.window.bounds.size.height/2);
    mortor.emitterShape = kCAEmitterLayerCircle;
    mortor.renderMode = kCAEmitterLayerAdditive;
    mortor.birthRate = 0;
    rocket = [CAEmitterCell emitterCell];

    rocket.scale			= 0.6;
    rocket.scaleSpeed		=-0.2;

    rocket.emissionLongitude = - M_PI;
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
    [self.window.layer addSublayer:mortor];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    beganPoint = [touch locationInView:self.window];
    mortor.emitterPosition = beganPoint;

    rocket.birthRate	= 40;			// every triangle creates 20
    rocket.velocity		= 50;
    rocket.emissionLongitude = M_PI * 0.5;	// sideways to triangle vector
    mortor.birthRate = 10;

}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.window];
    dispatch_async(dispatch_get_main_queue(), ^{
//        rocket.birthRate		= 30;			// every triangle creates 20
//        rocket.velocity			= 100;
        mortor.emitterPosition = point;
    });

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [mortor setValue:[NSNumber numberWithInteger:0] forKeyPath:@"birthRate"];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [mortor setValue:[NSNumber numberWithInteger:0] forKeyPath:@"birthRate"];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(float)getAngleWithToPoint:(CGPoint)toPoint FromPoint:(CGPoint)fromPoint{

    //两点的x、y值
    int deltaX = toPoint.x - fromPoint.x;
    int deltaY = toPoint.y - fromPoint.y;
    int singe;
    NSLog(@"deltaX = %d,deltaY = %d",deltaX,deltaY);
    if (deltaX > 0 && deltaY > 0) {
        singe = 3;
    }else if(deltaX < 0 && deltaY >= 0){
        singe = 0;
    }else if (deltaX > 0 && deltaY < 0){
        singe = 2;
    }else if(deltaX < 0 && deltaY <= 0){
        singe = 1;
    }
    NSLog(@"singe = %d",singe);
    deltaX = abs(deltaX);
    deltaY = abs(deltaY);

    int hypotenuse = sqrtf(pow(deltaX, 2)+pow(deltaY, 2));
    float cos = deltaX/hypotenuse;
    NSLog(@"cos = %f",cos);
    float radian = acos(cos);
    NSLog(@"radian = %f",radian);
    //求出弧度
    float angle = radian;
    angle = singe * M_PI_2 + angle;
    NSLog(@"angle = %f",-angle);
    return -angle;
}



@end
