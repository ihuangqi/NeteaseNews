//
//  DownloadManager.m
//  NeteasyNews
//
//  Created by 004 on 15/6/14.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "DownloadManager.h"
#import "DownloadObject.h"
#import "Network.h"
#import "RadioDetailModel.h"
#import "RadioListModel.h"

@implementation DownloadManager

static DownloadManager *manager;
- (instancetype)init
{
    self = [super init];
    if (self) {
        downloadingList = [NSMutableArray new];
        downloadedList = [NSMutableArray arrayWithArray:[DownloadObject getDownloadObjectFromLocation]];
    }
    return self;
}

+(instancetype)sharedManager{
    if (manager == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [[DownloadManager alloc] init];
        });
    }
    return manager;
}

-(void)addDownload:(DownloadObject *)downloadObject{
    [downloadingList addObject:downloadObject];
}
-(DownloadObject *)getObejctForDocid:(NSString *)docid{
    if ([self getDownloadedObjectForDocid:docid]) {
        return [self getDownloadedObjectForDocid:docid];
    }
    if ([self getDownloadingObjectForDocid:docid]) {
        return [self getDownloadingObjectForDocid:docid];
    }
    return nil;
}
-(void)remove:(NSString *)docid{
    DownloadObject *downloadObject = [self getObejctForDocid:docid];
    if (downloadObject) {
        [downloadObject removeFile];
    }else{
        [[[DownloadObject alloc] initWithDocid:docid] removeFile];
    }

}
#define DetailAPI @"http://c.3g.163.com/nc/article/%@/full.html"
-(void)addDownloadFromModel:(RadioListModel *)listModel setProgessBlack:(void (^)(float progress))setProgessBlack
{
    if (listModel.docid && [self isExist:listModel.docid]) {
        return;
    }
    [Network GetDataFromAFNetworkingWithURL:[NSString stringWithFormat:DetailAPI,listModel.docid] CallBack:^(id responseObject) {
        RadioDetailModel *model = [[RadioDetailModel alloc] initWithDictionary:responseObject];
        if ([model.docid isEqualToString:listModel.docid] && model.video.url_m3u8) {
            listModel.downloadState = DownloadStart;
            DownloadObject *downloadObject = [[DownloadObject alloc] initWithDocid:model.docid URL:[NSURL URLWithString:model.video.url_m3u8] setProgess:^(float progress) {
                if(progress == 1)
                {
                    listModel.downloadState = DownloadDone;
                    if (downloadObject && downloadObject->isDownloaded) {
                        [self->downloadedList addObject:downloadObject];
                        [self->downloadingList removeObject:downloadObject];
                    }
                }
                setProgessBlack(progress);

            }];
            if (downloadObject->isDownloaded) {
                [self->downloadedList addObject:downloadObject];
                [self->downloadingList removeObject:downloadObject];
            }
        }else{
            listModel.downloadState = DownloadFail;
        }
    }];
}

-(BOOL)isExist:(NSString *)docid{
    if([self getDownloadedObjectForDocid:docid] || [self getDownloadingObjectForDocid:docid]){
        return YES;
    }
    return NO;
}
-(DownloadObject *)getDownloadedObjectForDocid:(NSString *)docid{
    for (DownloadObject *downloadObject in downloadedList) {
        if ([downloadObject.docid isEqualToString:docid]) {
            return downloadObject;
        }
    }
    return nil;
}
-(DownloadObject *)getDownloadingObjectForDocid:(NSString *)docid{
    for (DownloadObject *downloadObject in downloadingList) {
        if ([downloadObject.docid isEqualToString:docid]) {
            return downloadObject;
        }
    }
    return nil;
}
+(NSMutableArray *)getDetailModelFromLocationAndCallBack:(void (^)())callback
{
    DownloadManager *sharedManager = [DownloadManager sharedManager];
    NSMutableArray *array = [NSMutableArray new];
    __block int i = 0;
    for (DownloadObject *object in sharedManager->downloadedList) {
        [Network GetDataFromAFNetworkingWithURL:[NSString stringWithFormat:DetailAPI,object.docid] CallBack:^(id responseObject) {
            RadioDetailModel *model = [[RadioDetailModel alloc] initWithDictionary:responseObject];
            if(model){
                model.downloadObject = object;
                [array addObject:model];
            }
            i ++;
            if(sharedManager->downloadedList.count <= i){
                callback();
            }
        }];
    }
    return array;
}
@end
