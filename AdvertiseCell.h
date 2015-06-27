//
//  AdvertiseCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/11.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateModel.h"
#import "DiscoveryBaseCell.h"

@interface AdvertiseCell : DiscoveryBaseCell
@property (nonatomic, strong) AdvertiseModel* model;
-(void)setModel:(AdvertiseModel *)model;
@property (nonatomic, strong) UIViewController* rootViewController;
@end
