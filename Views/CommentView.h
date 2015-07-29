//
//  CommentView.h
//  NeteasyNews
//
//  Created by 004 on 15/6/6.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
-(void)setModel:(CommentModel *)model;
@end
