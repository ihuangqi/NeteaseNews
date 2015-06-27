//
//  DownloadObject.h
//  NeteasyNews
//
//  Created by 004 on 15/6/14.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@interface DownloadObject : NSObject
{
    @public BOOL isDownloaded;
    NSString *path;
    void (^_setProgessBlack)(float progress);
}

@property (nonatomic, strong) NSString * docid;
@property (nonatomic, strong) NSURL* fileURL;
- (instancetype)initWithDocid:(NSString *)docid;
- (instancetype)initWithDocid:(NSString *)docid URL:(NSURL *)URL setProgess:(void (^)(float progress))setProgessBlack;
-(void)removeFile;


+(NSMutableArray *)getDownloadObjectFromLocation;
@end
