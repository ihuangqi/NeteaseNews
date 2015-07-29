//
//  CategoryModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/4.
//  Copyright (c) 2015年 新果. All rights reserved.
//
// 头条
#define kCategoryNameKey @"CategoryName"
#define kCategoryValueKey @"CategoryValue"
#define kPageStartKey @"PageStart"
#define kPageCountKey @"PageCount"
#define kCategoryPathKey @"CategoryPath"
#define kURLKey @"URL"
#define kSpecifyURLKey @"SpecifyURL"
#import "CategoryModel.h"
#import "UIView+ToastView.h"

#define NomarlAPI @"http://c.3g.163.com/nc/article/%@/%@/%d-%d.html"


@implementation CategoryModel

static CategoryModel* _selectedModel;
static NSMutableArray *allCategory;
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _name = dic[kCategoryNameKey];
        _value = dic[kCategoryValueKey];
        _path = dic[kCategoryPathKey];
        _pageStart = dic[kPageStartKey];
        _pageCount = dic[kPageCountKey];

        if (dic[kSpecifyURLKey]) {
            _specifyURL = dic[kSpecifyURLKey];
        }
    }
    return self;
}
+(NSMutableArray *)GetAllModel{
    if (allCategory.count > 0) {
        return allCategory;
    }
    [self readFromFile];

    if (allCategory.count > 0) {
        return allCategory;
    }


    allCategory = [NSMutableArray new];
    NSDictionary *dic;

    //头条
    dic = @{kCategoryNameKey:@"头条",
            kCategoryValueKey:@"T1348647909107",
            kCategoryPathKey:@"headline",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];
    //娱乐
    dic = @{kCategoryNameKey:@"娱乐",
            kCategoryValueKey:@"T1348648517839",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];
    //体育
    dic = @{kCategoryNameKey:@"体育",
            kCategoryValueKey:@"T1348649079062",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];
    //财经
    dic = @{kCategoryNameKey:@"财经",
            kCategoryValueKey:@"T1348648756099",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];
    //本地
    dic = @{kCategoryNameKey:@"本地",
            kCategoryValueKey:@"5rex5Zyz",
            kCategoryPathKey:@"local",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //热点   http://c.m.163.com/recommend/getSubDocPic?passport=&devId=359876052121654&size=20
    dic = @{kCategoryNameKey:@"热点",
            kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];


    //科技
    dic = @{kCategoryNameKey:@"科技",
            kCategoryValueKey:@"T1348649580692",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //汽车
    dic = @{kCategoryNameKey:@"汽车",
            kCategoryValueKey:@"T1348654060988",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //时尚
    dic = @{kCategoryNameKey:@"时尚",
            kCategoryValueKey:@"T1348650593803",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //TODO: 段子

    //TODO: 图片

    //轻松一刻
    dic = @{kCategoryNameKey:@"轻松一刻",
            kCategoryValueKey:@"T1350383429665",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //军事
    dic = @{kCategoryNameKey:@"军事",
            kCategoryValueKey:@"T1348648141035",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //历史
    dic = @{kCategoryNameKey:@"历史",
            kCategoryValueKey:@"T1368497029546",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //房产 http://c.m.163.com/nc/article/house/5rex5Zyz/0-20.html
    dic = @{kCategoryNameKey:@"房产",
            kCategoryPathKey:@"house",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //游戏
    dic = @{kCategoryNameKey:@"游戏",
            kCategoryValueKey:@"T1348654151579",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //彩票
    dic = @{kCategoryNameKey:@"彩票",
            kCategoryValueKey:@"T1356600029035",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //原创
    dic = @{kCategoryNameKey:@"原创",
            kCategoryValueKey:@"T1370583240249",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    //政务
    dic = @{kCategoryNameKey:@"政务",
            kCategoryValueKey:@"T1414142214384",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
    [allCategory addObject:[[CategoryModel alloc] initWithDictionary:dic]];

    [self writeToFile];
    return allCategory;
}
-(NSString *)url{
    if ([_name  isEqual: @"热点"]) {
        _url = [NSString stringWithFormat:@"http://c.m.163.com/recommend/getSubDocPic?passport=&devId=359876052121654&size=%d",[_pageCount intValue]];
    }else if([_name isEqual:@"房产"]){
        _url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/house/%@/%d-%d.html",_path,[_pageStart intValue],[_pageCount intValue]];
    }else{
        _url = [NSString stringWithFormat:NomarlAPI,_path,_value, [_pageStart intValue], [_pageCount intValue]];
    }
    return _url;
}

-(void)get{
    //每日要闻
    NSDictionary *dic;
    dic = @{kCategoryNameKey:@"每日要闻",
            kCategoryValueKey:@"T1371543208049",
            kCategoryPathKey:@"list",
            kPageStartKey:@(0),kPageCountKey:@(20)};
}

+(void)readFromFile{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"Data"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:@"AllCategory.plist"];

    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    if (array == nil ||array.count == 0) {
        [UIView showToaseViewWithText:[NSString stringWithFormat:@"读取AllCategory%@",@"失败"] Time:3];
        return ;
    }
    allCategory = [NSMutableArray new];
    for (NSDictionary *dic in array) {
        CategoryModel *model = [[CategoryModel alloc] initWithDictionary:dic];
        [allCategory addObject:model];
    }
//    return allCategory;
}
+(void)writeToFile{
//    if (allCategory.count == 0) {
//        return;
//    }

    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"Data"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:@"AllCategory.plist"];
    NSDictionary *dic;
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0 ; i < allCategory.count ; i++) {
        CategoryModel *model = allCategory[i];
        dic = @{kCategoryNameKey:model.name ? model.name :@"",
                kCategoryValueKey:model.value ? model.value : @"",
                kCategoryPathKey:model.path ? model.path :@"",
                kPageStartKey:model.pageStart ? model.pageStart :@(0),
                kPageCountKey:model.pageCount ? model.pageCount :@(0)
                };
        [array addObject:dic];
    }
    BOOL isSucceed = [array writeToFile:path atomically:YES];
    [UIView showToaseViewWithText:[NSString stringWithFormat:@"保存AllCategory%@",isSucceed ? @"成功" : @"失败"] Time:3];
}

+(CategoryModel *)selectedModel{
    return _selectedModel;
}
+(void)setSelectedModel:(CategoryModel *)selectedModel{
    _selectedModel.isSelected = NO;
    selectedModel.isSelected = YES;
    _selectedModel = selectedModel;
}
@end
