//
//  CategoryCell.h
//  NeteasyNews
//
//  Created by 004 on 15/6/19.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface CategoryCell : UICollectionViewCell
@property (nonatomic, strong) CategoryModel* model;
@property (nonatomic, weak) NSIndexPath* indexPath;
@end
