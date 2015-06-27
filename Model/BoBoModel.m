//
//  BoBoModel.m
//  NeteasyNews
//
//  Created by 004 on 15/6/4.
//  Copyright (c) 2015年 新果. All rights reserved.
//
#define PropertyToString(arg) _TOBANK(_TOBANK(@"" #arg))
#define _TOBANK(arg) [arg stringByReplacingOccurrencesOfString:@"_" withString:@""]
#define GetPropertyForDictionary(property) property = dic[PropertyToString(property)]

#import "BoBoModel.h"

@implementation BoBoModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        GetPropertyForDictionary(_anchorCategory);
        GetPropertyForDictionary(_sex);
        GetPropertyForDictionary(_location);
        GetPropertyForDictionary(_ownerId);
        GetPropertyForDictionary(_roomId);
        GetPropertyForDictionary(_followsCount);
        GetPropertyForDictionary(_avatar);
        GetPropertyForDictionary(_cost);
        GetPropertyForDictionary(_userNum);
        GetPropertyForDictionary(_duration);
        GetPropertyForDictionary(_cover);
        GetPropertyForDictionary(_liveBegin);
        GetPropertyForDictionary(_level);
        GetPropertyForDictionary(_nick);
        GetPropertyForDictionary(_roomType);
        GetPropertyForDictionary(_roomName);
        GetPropertyForDictionary(_familyCover);
        GetPropertyForDictionary(_familyAvatar);
        GetPropertyForDictionary(_userId);
        GetPropertyForDictionary(_serialVersionUID);
        GetPropertyForDictionary(_badge);
        GetPropertyForDictionary(_followedCount);
        GetPropertyForDictionary(_crowd);
        GetPropertyForDictionary(_anchorType);
        GetPropertyForDictionary(_live);
    }
    return self;
}
+(NSString *)getURLString{
    return @"http://www.bobo.com/spe-data/api/anchors-hot.htm";
}
+(NSMutableArray *)GetBoBoModel:(NSArray  *)array{
    NSMutableArray *result = [NSMutableArray new];
    for (NSDictionary *dic in array) {
        BoBoModel *model = [[BoBoModel alloc] initWithDictionary:dic];
        [result addObject:model];
    }
    return result;
}
-(void)setView:(UIImageView *)imageView{
    ;
}
@end
