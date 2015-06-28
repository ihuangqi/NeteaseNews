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
@interface AppDelegate (){
   BOOL isStopAnimation;
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
