//
//  SportsCustomCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/5.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "SportsCustomCell.h"
#import "SportsModel.h"
#import "UIImageView+WebCache.h"
@implementation SportsCustomCell
{
    __weak IBOutlet UIImageView *hostImageView1;
    __weak IBOutlet UILabel     *hostNameLabel1;

    __weak IBOutlet UIImageView *visitImageView1;
    __weak IBOutlet UILabel     *visitNameLabel1;

    __weak IBOutlet UILabel     *leagueNameLabel1;
    __weak IBOutlet UILabel     *scoreLabel1;
    __weak IBOutlet UILabel     *statusDescLabel1;





    __weak IBOutlet UIImageView *hostImageView2;
    __weak IBOutlet UILabel     *hostNameLabel2;

    __weak IBOutlet UIImageView *visitImageView2;
    __weak IBOutlet UILabel     *visitNameLabel2;

    __weak IBOutlet UILabel     *leagueNameLabel2;
    __weak IBOutlet UILabel     *scoreLabel2;
    __weak IBOutlet UILabel     *statusDescLabel2;


}
- (void)awakeFromNib {
    // Initialization code
    statusDescLabel1.clipsToBounds = YES;
    statusDescLabel1.backgroundColor = [UIColor blueColor];
    statusDescLabel1.layer.cornerRadius = 8;
    statusDescLabel2.clipsToBounds = YES;
    statusDescLabel2.backgroundColor = [UIColor blueColor];
    statusDescLabel2.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(NSArray *)array{
    SportsModel *sprotsModel1 = array[0];
    SportsModel *sprotsModel2 = array[1];


    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:sprotsModel1.visitLogoUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            visitImageView1.image = [UIImage imageWithData:data];
        });
    });
    visitNameLabel1.text = sprotsModel1.visitName;

    leagueNameLabel1.text = sprotsModel1.leagueName;
    if ([sprotsModel1.statusDesc isEqualToString:@"未开赛"]) {
        scoreLabel1.text = [self getStringFromDataString:sprotsModel1.startTime];
    }else{
        scoreLabel1.text = sprotsModel1.score;
    }
    statusDescLabel1.text = [[@" " stringByAppendingString:sprotsModel1.statusDesc] stringByAppendingString:@"  "];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:sprotsModel1.hostLogoUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            hostImageView1.image = [UIImage imageWithData:data];
        });
    });
    hostNameLabel1.text = sprotsModel1.hostName;
    NSLog(@"%@",sprotsModel1.hostLogoUrl);


    [visitImageView2 sd_setImageWithURL:[NSURL URLWithString:sprotsModel2.visitLogoUrl]];
    visitNameLabel2.text = sprotsModel2.visitName;

    leagueNameLabel2.text = sprotsModel2.leagueName;
    if ([sprotsModel2.statusDesc isEqualToString:@"未开赛"]) {
        scoreLabel2.text = [self getStringFromDataString:sprotsModel2.startTime];
    }else{
        scoreLabel2.text = sprotsModel2.score;
    }
    statusDescLabel2.text = [[@" " stringByAppendingString:sprotsModel2.statusDesc] stringByAppendingString:@"  "];

    [hostImageView2 sd_setImageWithURL:[NSURL URLWithString:sprotsModel2.hostLogoUrl]];
    hostNameLabel2.text = sprotsModel2.hostName;
    NSLog(@"%@",sprotsModel1.hostLogoUrl);


}

-(NSString *)getStringFromDataString:(NSString *)string{



    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"]];
    NSDate *date = [dateFormatter dateFromString:string];



    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:now];

    NSInteger nowWeek = [comps weekday];
    NSInteger nowmonth = [comps month];
    NSInteger nowDay = [comps day];
    NSInteger nowHour = [comps hour];
    NSInteger nowMinute = [comps minute];

    NSDateComponents *datedd = [calendar components:unitFlags fromDate:date];
    NSInteger dateWeek = [datedd weekday];
    NSInteger datemonth = [datedd month];
    NSInteger dateDay = [datedd day];
    NSInteger dateHour = [datedd hour];
    NSInteger dateMinute = [datedd minute];

    switch (dateDay - nowDay) {
        case 0:
            return [NSString stringWithFormat:@"今天\n%02ld:%02ld",dateHour,dateMinute];
            break;
        case 1:
            return [NSString stringWithFormat:@"明天\n%02ld:%02ld",dateHour,dateMinute];
            break;
        case 2:
            return [NSString stringWithFormat:@"后天\n%02ld:%02ld",dateHour,dateMinute];
            break;
        default:
            return [NSString stringWithFormat:@"%ld-%ld\n%02ld:%02ld",datemonth,dateDay,dateHour,dateMinute];
            break;
    }

}

-(void)gotoDetialView{

}
@end
