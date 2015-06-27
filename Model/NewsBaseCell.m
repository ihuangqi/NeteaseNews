//
//  NewsBaseModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/15.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "NewsBaseCelll.h"
#import "DetailViewController.h"

#define kRootControllerKey @"RootController"

@implementation NewsBaseCelll
- (void)gotoDetialView:(NSDictionary *)dic
{
    if (!_rootViewController || dic == nil)
    {
        return;
    }

    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.parameterDictionary = dic;
    if ([_rootViewController isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)_rootViewController pushViewController:detailViewController animated:YES];
    }
    
}
@end
