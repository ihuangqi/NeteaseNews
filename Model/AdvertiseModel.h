//
//  AdvertiseModel.h
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertiseModel : NSObject
{
    NSString* _imageURLPath;
    NSString* _titleLabeText;
    NSString* _subTitleLabelText;
    NSString* _detailURL;
    NSMutableArray* _subItem;
}
@property (nonatomic, strong) NSString* imageURLPath;
@property (nonatomic, strong) NSString* titleLabeText;
@property (nonatomic, strong) NSString* subTitleLabelText;
@property (nonatomic, strong) NSString* detailURL;
@property (nonatomic, strong) NSMutableArray* subItem;
@end
