//
//  NewsView.h
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"


#define kCategoryModelKey @"CategoryMode"
#define kNewsModelArrayKey @"NewsModelArray"
#define kRootControllerKey @"RootController"

#define kCategoryViewKey @"CategoryView"

#define kDefanltBackgroundColor [UIColor colorWithRed:0.957 green:0.953 blue:0.953 alpha:1.000]

#define kNormalCellIdentifier @"NewsCell"
#define kImgextraNewsCellIdentifier @"ImgextraNewsCell"
#define kSportsCustomCellIdentifier @"SportsCustomCell"
#define kEntertainmentCellIdentifier @"EntertainmentCell"
#define kLocalCellIdentifier @"LocalCell"



@interface NewsView : UIView

@property (nonatomic, weak) UIViewController* rootViewController;

- (instancetype)initWithFrame:(CGRect)frame WithParameterDictionary:(NSDictionary *)dic;
@property (nonatomic, strong) UITableView *tableView;

@end
