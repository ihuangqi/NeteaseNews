//
//  CustomCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/4.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsBaseCelll.h"

@interface EntertainmentCell : NewsBaseCelll
@property (weak, nonatomic) IBOutlet UIImageView *OneImageVIew;
@property (weak, nonatomic) IBOutlet UIImageView *TwoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ThreeImageView;
@property (nonatomic, strong) NSArray* modelArray;
-(void)setModel:(NSArray *)modelArray;
-(void)gotoDetialView;
@end
