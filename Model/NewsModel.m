//
//  NewsModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/3.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionaru(property) property = dic[PropertyToString(property)]


#import "NewsModel.h"
@implementation NewsModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionaru(_hasCover);
        GetPropertyForDictionaru(_hasHead);

        _replyCount = [dic[PropertyToString(_replyCount)] stringValue];

        GetPropertyForDictionaru(_hasImg);
        GetPropertyForDictionaru(_digest);
        GetPropertyForDictionaru(_hasIcon);
        GetPropertyForDictionaru(_docid);
        GetPropertyForDictionaru(_title);
        GetPropertyForDictionaru(_order);
        GetPropertyForDictionaru(_priority);
        GetPropertyForDictionaru(_lmodify);
        GetPropertyForDictionaru(_boardid);
        GetPropertyForDictionaru(_url_3w);
        GetPropertyForDictionaru(_template);
        GetPropertyForDictionaru(_votecount);
        GetPropertyForDictionaru(_alias);
        GetPropertyForDictionaru(_cid);
        GetPropertyForDictionaru(_url);
        GetPropertyForDictionaru(_hasAD);
        GetPropertyForDictionaru(_source);
        GetPropertyForDictionaru(_subtitle);
        GetPropertyForDictionaru(_imgsrc);
        GetPropertyForDictionaru(_tname);
        GetPropertyForDictionaru(_ename);
        GetPropertyForDictionaru(_ptime);

        self.TAG = dic[PropertyToString(_TAG)];

        if (dic[PropertyToString(_imgextra)] && [dic[PropertyToString(_imgextra)] isKindOfClass:[NSArray class]] ){
            _imgextra = [NSMutableArray new];
            for (NSDictionary *childDic in dic[PropertyToString(_imgextra)]) {
                NSString *imagePath = childDic[@"imgsrc"];
                [_imgextra addObject:imagePath];
            }
        }

        if (_digest) {
            _isShowDigest = YES;
        }

        if([_replyCount intValue] > 0){
            _isShowPeplyCount = YES;
        }

        _isShowNewPreadButton = NO;

        _showLoactionOfTag = ShowLocationNone;
        _showLoactionOfreplyCount = ShowLocationNone;

    }

        return self;
}

-(void)setCategoryModel:(CategoryModel *)categoryModel{

    NSString* categoryName = categoryModel.name;
    _showLoactionOfTag =ShowLocationNone;
    if ([categoryName isEqualToString:@"热点"] ||[categoryName isEqualToString:@"本地"] ) {
        _isShowDigest = NO;
        _isShowSource = YES;
        if (_TAG) {
            if([categoryName isEqualToString:@"热点"]){
                _showLoactionOfTag = ShowLocationLeftButtom;
            }else if([categoryName isEqualToString:@"本地"]){
                _showLoactionOfTag = ShowLocationRightButtom;
            }
        }
        if ([_replyCount intValue] > 0) {
            _isShowPeplyCount = YES;
        }
        if ([categoryName isEqualToString:@"热点"]) {
            _isShowNewPreadButton = YES;
        }
    }else if ([categoryName isEqualToString:@"头条"]){
        _showLoactionOfTag = ShowLocationRightButtom;
        _showLoactionOfreplyCount = ShowLocationRightButtom;
    }else{
        _showLoactionOfTag = ShowLocationNone;
        _showLoactionOfreplyCount = YES;
        _isShowNewPreadButton = NO;
    }



}
-(void)setTAG:(NSString *)TAG{
    if (TAG == nil) {
        return;
    }
    if ([TAG isEqualToString:@"LIVE"]) {
        _TAG = @"直播";
    }else{
        _TAG = TAG;
    }
}

+(NSMutableArray *)getNewsModelArrayFromResponse:(id) response{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray new] ;
    for (NSDictionary *dic in response[[response allKeys][0]]) {
        NewsModel *newsModel = [[NewsModel alloc] initWithDictionary:dic];
        [array addObject:newsModel];
    }
    return array;
}
@end
