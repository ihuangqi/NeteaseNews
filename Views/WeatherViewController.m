//
//  WeatherViewController.m
//  NeteasyNews
//
//  Created by 004 on 15/6/16.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define API @"http://c.m.163.com/nc/weather/5bm%2F5LicfOa3seWcsw%3D%3D.html"

#import "WeatherViewController.h"
#import "Network.h"
#import "WeatherModel.h"
#import "DayWeatherModel.h"

@interface WeatherViewController ()
{
    WeatherModel *weatherModel;
    __weak IBOutlet UIImageView *tenPicture;
    __weak IBOutlet UIImageView *onePicture;
    __weak IBOutlet UILabel *tempLabel;
    __weak IBOutlet UILabel *todayLabel;
    __weak IBOutlet UILabel *pmLabel;

    __weak IBOutlet UIImageView *weatherPicture;
    __weak IBOutlet UILabel *weatherLabel;
    __weak IBOutlet UILabel *windLabel;
    __weak IBOutlet UILabel *locationLabel;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Network GetDataFromAFNetworkingWithURL:API CallBack:^(id responseObject) {
        weatherModel = [[WeatherModel alloc] initWithDictionary:responseObject];

        if (weatherModel != nil) {
            [self reloadView];
        }
    }];

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

-(void)reloadView{
    int temp = [weatherModel.rt_temperature intValue];
    int tenNum = temp / 10;
    int oneNum = temp % 10;

    tenPicture.image = [UIImage imageNamed:[NSString stringWithFormat:@"biz_more_menu_t%d",tenNum]];
    onePicture.image = [UIImage imageNamed:[NSString stringWithFormat:@"biz_more_menu_t%d",oneNum]];

    DayWeatherModel *dayWeatherModel = weatherModel.dayWeatherModelList.count ? weatherModel.dayWeatherModelList[0] : nil;
    tempLabel.text = dayWeatherModel ? dayWeatherModel.temperature : nil;

    PM2D5Model *pm2d5 = weatherModel.pm2d5;
    if (pm2d5.pm2_5) {
        NSString *string ;
        if ([pm2d5.pm2_5 intValue] > 10) {
            string = @" 优";
        }else if([pm2d5.pm2_5 intValue] > 5){
            string = @" 一般";
        }else{
            string = @" 差";
        }
        pmLabel.text = [[@"PM2.5 " stringByAppendingString:pm2d5.pm2_5] stringByAppendingString:string];
    }else{
        pmLabel.text = nil;
    }
    if (weatherModel.dt) {
        todayLabel.text = [[weatherModel.dt stringByAppendingString:@" "] stringByAppendingString:dayWeatherModel.week];
    }


    dayWeatherModel.climate ? weatherLabel.text = dayWeatherModel.climate : nil;
    dayWeatherModel.wind ? windLabel.text = dayWeatherModel.wind : nil;

    if (dayWeatherModel.climate) {

        NSMutableString *source = [dayWeatherModel.climate mutableCopy];

        CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);

        CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
        NSLog(@"%@", source);
        weatherPicture.image = [UIImage imageNamed:[NSString stringWithFormat:@"biz_simple_weather_%@",[source stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    }else{
        weatherPicture.image = nil;
    }


    locationLabel.text = @"深圳";



}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
        _buttonWidth.constant = 80;
    [UIView animateWithDuration:1
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
