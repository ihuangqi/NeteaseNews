//
//  DiscoveryBaseCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoveryBaseCell : UITableViewCell
{
    UIViewController* _rootViewController;
}
@property (nonatomic, strong) UIViewController* rootViewController;
-(void)gotoNextView:(NSString *)urlString FromView:(UIView *)fromView;
@end
