//
//  DetailNewsModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/6.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define PropertyToString(arg) _TOBANK(@"" #arg)
#define _TOBANK(arg) [arg stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]



#import "DetailNewsModel.h"
#import "DetailViewController.h"
#import "AFHTTPRequestOperationManager.h"


@implementation DetailNewsModel
- (instancetype)initWithDictionary:(NSDictionary *)objc
{
    if (![objc isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSDictionary *dic = objc[[objc allKeys][0]];
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_body);
        GetPropertyForDictionary(_users);
        GetPropertyForDictionary(_replyCount);
        GetPropertyForDictionary(_link);
        GetPropertyForDictionary(_votes);
        GetPropertyForDictionary(_digest);
        GetPropertyForDictionary(_topiclist_news);
        GetPropertyForDictionary(_topiclist);
        GetPropertyForDictionary(_docid);
        GetPropertyForDictionary(_title);
        GetPropertyForDictionary(_picnews);
        GetPropertyForDictionary(_tid);
        GetPropertyForDictionary(_template);
        GetPropertyForDictionary(_threadVote);
        GetPropertyForDictionary(_relative);
        GetPropertyForDictionary(_threadAgainst);
        GetPropertyForDictionary(_boboList);
        GetPropertyForDictionary(_replyBoard);
        GetPropertyForDictionary(_source);
        GetPropertyForDictionary(_hasNext);
        GetPropertyForDictionary(_voicecomment);
        GetPropertyForDictionary(_apps);
        GetPropertyForDictionary(_ptime);

        NSArray *array;
        array = dic[PropertyToString(_img)];


        if (array.count > 0 && [array isKindOfClass:[NSArray class]]) {
            _img = [NSMutableArray new];
            for (NSDictionary *childDic in array) {
                ImgModel *img = [[ImgModel alloc] initWithDictionary:childDic];
                [_img addObject:img];
                if (img.src && img.ref) {
                    if ([self.body rangeOfString:img.ref].length > 0) {
                        NSString *string = [NSString stringWithFormat:@"<p><style>.imgclass { background-color: #FFFFFF;color:#999999}</style><div style=\"float:center;text-align:left;\"><img src=\"%@\"  alt=\"%@\" /><span style=\"font-size:12px\" class=\"imgclass\">%@</span></div></p>",img.src,img.alt,img.alt];
                        self.body = [self.body stringByReplacingOccurrencesOfString:img.ref withString:string];
                    }
                }
            }
            //<img src="/i/eg_tulip.jpg"  alt="上海鲜花港 - 郁金香" />
        }


        array = dic[PropertyToString(_video)];
        if (array.count > 0 && [array isKindOfClass:[NSArray class]]) {

            _video = [NSMutableArray new];
            for (NSDictionary *childDic in array) {
                VideoModel* video = [[VideoModel alloc] initWithDictionary:childDic];
                [_video addObject:video];
                if (video.url_m3u8 && video.ref) {
                    if ([self.body rangeOfString:video.ref].length > 0) {
                        //@"<video src=\"%@\" id=\"myVideo\" controls preload wight=\"%d\" height=\"%d\">您的浏览器不支持video标签</video>"
                        NSString *string = [NSString stringWithFormat:@"<p><style>.videoclass { background-color: #FFFFFF;color:#999999}</style><div style=\"float:center;text-align:left;\"><video src=\"%@\" id=\"myVideo\" controls preload wight=\"%d\" height=\"%d\">您的浏览器不支持video标签</video><span style=\"font-size:12px\" class=\"videoclass\">%@</span></div></p>",video.url_m3u8,(int)([UIScreen mainScreen].bounds.size.width - 20),(int)(([UIScreen mainScreen].bounds.size.width - 20) * 9.0 / 16),video.alt];
                        //                    NSString *string = [NSString stringWithFormat:@"<video src=\"%@\" controls preload height=\"100\%\">您的浏览器不支持video标签</video>",_video.url_m3u8];

                        self.body = [self.body stringByReplacingOccurrencesOfString:video.ref withString:string];
                    }

                }

            }

        }



    }



    return self;
}
+(NSArray *)getDetailNewsModel:(id)response
{
    DetailNewsModel *model = [[DetailNewsModel alloc] initWithDictionary:response];
    return @[model];
}
//+(void)setDetilView:(NSDictionary *)parameter{
//    NSString *API = @"http://c.m.163.com/nc/article/%@/full.html";
//    DetailViewController *detailViewController= parameter[kDetilViewKey];
//    NSString *docid = parameter[kdocidKey];
//    NSString *url = [NSString stringWithFormat:API,docid];
//    NSLog(@"url ==%@",url);
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NSArray *array = [self getDetailNewsModel:response];
//        if (array.count > 0) {
//            [detailViewController setModel:array[0]];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"请求失败");
//        for (CommentView* commentView in commentViewArray) {
//            [commentView.superview removeFromSuperview];
//        }
//    }];
//}


@end
