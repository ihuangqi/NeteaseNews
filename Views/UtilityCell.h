//
//  UtilityCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoveryBaseCell.h"

@interface UtilityCell : DiscoveryBaseCell
-(void)setDictionary:(NSDictionary *)dic;

@property (nonatomic, strong) UIViewController* rootViewController;
@property (nonatomic, strong) NSArray *recommend;
@property (nonatomic, strong) NSArray *banner;
@end
