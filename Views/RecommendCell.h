//
//  RecommendCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/8.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
#import "UIImage+WebP.h"
#import "ReadBaseCell.h"
@interface RecommendCell : ReadBaseCell
{
    UIViewController* _rootiewController;
}
    
@property (nonatomic, strong) RecommendModel* model;
@end
