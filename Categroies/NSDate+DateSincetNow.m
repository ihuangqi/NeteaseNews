//
//  NSDate+DateSincetToday.m
//  NeteasyNews
//
//  Created by 004 on 15/6/7.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "NSDate+DateSincetNow.h"

@implementation NSDate (DateSincetNow)
+(NSDictionary *)getStringFromDataString:(NSString *)string dateFormatString:(NSString *)formatterString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterString];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"]];
    NSDate *date = [dateFormatter dateFromString:string];
    if (!date) {
        return nil;
    }
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:now];
    NSInteger nowyear = [comps year];
    NSInteger nowmonth = [comps month];
    NSInteger nowWeek = [comps weekday];
    NSInteger nowDay = [comps day];
    NSInteger nowHour = [comps hour];
    NSInteger nowMinute = [comps minute];

    NSDateComponents *datedd = [calendar components:unitFlags fromDate:date];
    NSInteger dateyear = [datedd year];
    NSInteger datemonth = [datedd month];
    NSInteger dateWeek = [datedd weekday];
    NSInteger dateDay = [datedd day];
    NSInteger dateHour = [datedd hour];
    NSInteger dateMinute = [datedd minute];


    NSString *howHourString;
    if (nowyear > dateyear) {
        howHourString = string;
    }else if(nowyear == dateyear){
        if (nowmonth > datemonth) {
            howHourString = string;
        }else if (nowmonth == datemonth){
            if (nowDay - dateDay > 2) {
                howHourString = string;
            }else{
                NSInteger howHourSinceNow = (nowDay - dateDay) * 24 + nowHour - dateHour;
                if (howHourSinceNow == 0){
                    howHourString = [NSString stringWithFormat:@"1小时内"];
                }else{
                    howHourString = [NSString stringWithFormat:@"%ld小时前",howHourSinceNow];
                }
            }
        }else{
            
        }

    }else{

    }

        NSString *dayString;
    NSString *timeString;
    switch (dateDay - nowDay) {
        case 0:
            dayString = @"今天";
            break;
        case 1:
            dayString = @"明天";
            break;
        case 2:
            dayString = @"后天";
            break;
        default:
            dayString = [NSString stringWithFormat:@"%ld-%ld",datemonth,dateDay];
            break;
    }
    timeString = [NSString stringWithFormat:@"%02ld:%02ld",dateHour,dateMinute];
    return @{kDayKey:dayString,kTimeKey:timeString,kHowHourSinceNowKey:howHourString};
}
@end
