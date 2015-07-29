//
//  RadioPlayView.h
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DownloadObject.h"

#define kLoctionRadioKey @"LoctionRadio"

@interface RadioDetialView : UIView
@property (nonatomic, strong) UIViewController* rootViewController;
@property (nonatomic, strong) NSDictionary* parameterDictionary;

@end
