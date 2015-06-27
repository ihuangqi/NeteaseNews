//
//  DownloadObject.m
//  NeteasyNews
//
//  Created by 004 on 15/6/14.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "DownloadObject.h"
#import "AFNetworking.h"
@interface DownloadObject()<NSURLConnectionDataDelegate>
{
    long long downloadedFileSize;
    long long int contentSize;
    NSFileHandle *fileHandle;

}


@end
@implementation DownloadObject
- (instancetype)initWithDocid:(NSString *)docid{
    self = [super init];
    if (self) {
        _docid = docid;
        path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] ;
        path = [path stringByAppendingPathComponent:[_docid stringByAppendingString:@".mp3.tmp"]];
    }
    return self;
}
- (instancetype)initWithDocid:(NSString *)docid URL:(NSURL *)URL setProgess:(void (^)(float progress))setProgessBlack
{
    self = [self initWithDocid:docid];
    if (self) {

        _setProgessBlack = setProgessBlack;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:[path stringByReplacingOccurrencesOfString:@".tmp" withString:@""]] ) {
            path = [path stringByReplacingOccurrencesOfString:@".tmp" withString:@""];
            _fileURL = [NSURL URLWithString:path];
            isDownloaded = YES;
            return self;
        }
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        if (![fileManager fileExistsAtPath:path]) {
            [fileManager createFileAtPath:path contents:nil attributes:nil];
        }else{
            NSDictionary *fileAttribute = [fileManager attributesOfItemAtPath:path error:nil];
            downloadedFileSize = [fileAttribute[NSFileSize] unsignedLongLongValue];
            [request addValue:[NSString stringWithFormat:@"bytes=%qu-",downloadedFileSize] forHTTPHeaderField:@"RANGE"];
        }
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [NSURLConnection connectionWithRequest:request delegate:self];

    }
    return self;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    contentSize = response.expectedContentLength;
    if (downloadedFileSize >= contentSize) {
        isDownloaded = YES;
        [connection cancel];
        connection = nil;
        _setProgessBlack(1);
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
        [fileHandle writeData:data];
        NSDictionary *fileAttribute = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        long long int fileSize = [fileAttribute[NSFileSize] unsignedLongLongValue];
        _setProgessBlack((CGFloat)fileSize / contentSize);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

    isDownloaded = YES;
    connection = nil;
    _setProgessBlack(1);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager moveItemAtPath:path toPath:[path stringByReplacingOccurrencesOfString:@".tmp" withString:@""] error:nil];
    path = [path stringByReplacingOccurrencesOfString:@".tmp" withString:@""];
    _fileURL = [NSURL URLWithString:path];
}

-(void)removeFile{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
    }
}

+(NSMutableArray *)getDownloadObjectFromLocation{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] ;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    NSLog(@"%@",array);
    NSMutableArray *resultArray = [NSMutableArray new];
    for (NSString *string in array) {
        if ([string hasSuffix:@".mp3"]) {
            DownloadObject *object = [[DownloadObject alloc] initWithDocid:[string  substringToIndex:[string length] - 4]];
            object->path = [path stringByAppendingPathComponent:string];
            object.fileURL = [NSURL fileURLWithPath:path];
            [resultArray addObject:object];
        }
    }
    return resultArray;
}
+ (NSArray*) allFilesAtPath:(NSString*) dirString {
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:10];
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSArray* tempArray = [fileMgr contentsOfDirectoryAtPath:dirString error:nil];
    for (NSString* fileName in tempArray) {
        BOOL flag = YES;
        NSString* fullPath = [dirString stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {
                [array addObject:fullPath];
            }
        }
    }
    return array;
}
@end
