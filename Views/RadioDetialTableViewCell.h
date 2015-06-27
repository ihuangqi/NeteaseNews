//
//  RadioDetialTableViewCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/13.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioListModel.h"

@interface RadioDetialTableViewCell : UITableViewCell
@property (nonatomic, strong) RadioListModel* model;

-(void)loadView;
@end
