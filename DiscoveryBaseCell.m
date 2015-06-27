//
//  DiscoveryBaseCell.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "DiscoveryBaseCell.h"
#import "WebViewController.h"

@interface DiscoveryBaseCell()
@end


@implementation DiscoveryBaseCell
{
    NSString *htmlBody;
    BOOL isLoaded;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)gotoNextView:(NSString *)urlString FromView:(UIView *)fromView{
    UIColor *color = fromView.backgroundColor;
    fromView.backgroundColor = [UIColor greenColor];

     WebViewController *viewController = [[WebViewController alloc] init];
    viewController.urlString = urlString;
    [self.rootViewController presentViewController:viewController animated:YES completion:^{
        fromView.backgroundColor = color;
    }];

}

@end
