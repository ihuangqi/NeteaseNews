//
//  DownloadManager.h
//  NeteasyNews
//
//  Created by 004 on 15/6/14.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadioDetailModel.h"
#import <UIKit/UIKit.h>
#import "RadioListModel.h"
@interface DownloadManager : NSObject
{
    NSMutableArray *downloadingList;
    NSMutableArray *downloadedList;

}

-(void)remove:(NSString *)docid;
-(BOOL)isExist:(NSString *)docid;
-(DownloadObject *)getDownloadedObjectForDocid:(NSString *)docid;
-(void)addDownloadFromModel:(RadioListModel *)listModel setProgessBlack:(void (^)(float progress))setProgessBlack;
+(instancetype)sharedManager;

+(NSMutableArray *)getDetailModelFromLocationAndCallBack:(void (^)())callback;
@end
