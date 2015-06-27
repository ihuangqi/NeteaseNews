//
//  AllColunmsView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/10.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "AllColunmsView.h"
#import "Network.h"
#import "ColumnsListModel.h"
#import "ColumnsModel.h"
#import "UIImageView+SetWebPImage.h"
#import "ColumnsListCell.h"
#import "MBProgressHUD.h"

#define kColumnsListCellKey @"ColumnsListCell"

#define AllColunmsAPI @"http://c.m.163.com/nc/topicset/android/v4/subscribe/read/all.html"
#define RecommendAPI @"http://c.m.163.com/nc/topicset/android/v4/subscribe/read/recommend.html"

@interface AllColunmsView()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation AllColunmsView
{
    BOOL isSearching;

    UIVisualEffectView *effectView;

    __weak IBOutlet UITextField *_textField;
    __weak IBOutlet NSLayoutConstraint *titleContrast;
    __weak IBOutlet UILabel *titleLabel;

    __weak IBOutlet UIView *searchToolView;
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIImageView *separatorView;
    __weak IBOutlet UIScrollView *_scrolView;
    __weak IBOutlet UITableView *_tableView;
    UITableView *filterTableView;

    NSMutableArray *allColunmsArray;
    NSMutableArray *recommendArray;

    NSMutableArray *dataArray;
    int colunmsButtonWidth;
    int colunmsButtonHeight;

    NSMutableArray *buttonArray;

    NSMutableArray  *filterArray;

}

-(void)awakeFromNib{
    [_tableView registerNib:[UINib nibWithNibName:@"ColumnsListCell" bundle:nil] forCellReuseIdentifier:kColumnsListCellKey];
    separatorView.image = [[UIImage imageNamed:@"base_bottom_fade_drawable"]stretchableImageWithLeftCapWidth:15 topCapHeight:100];
    buttonArray = [NSMutableArray new];
    filterTableView = [[UITableView alloc] initWithFrame:contentView.bounds];
    [filterTableView registerNib:[UINib nibWithNibName:@"ColumnsListCell" bundle:nil] forCellReuseIdentifier:kColumnsListCellKey];
    filterTableView.delegate = self;
    filterTableView.dataSource = self;
    filterTableView.backgroundColor = [UIColor clearColor];
    filterTableView.separatorStyle = UITableViewCellSelectionStyleNone;


    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;


    filterTableView.rowHeight = UITableViewAutomaticDimension;
    filterTableView.estimatedRowHeight = 100;

}
-(void)setRootViewController:(UIViewController *)rootViewController{
    _rootViewController = rootViewController;
    [MBProgressHUD showHUDAddedTo:_tableView.superview animated:YES];
    [Network GetDataFromAFNetworkingWithURL:RecommendAPI CallBack:^(id responseObject) {
        recommendArray = [ColumnsListModel getRecommendColumnsListModelFromResponse:responseObject];
        [Network GetDataFromAFNetworkingWithURL:AllColunmsAPI CallBack:^(id responseObject) {
            allColunmsArray = [ColumnsListModel getAllColumnsListModelFromResponse:responseObject];
            [self reloadView];

        }];
    }];

}

-(void)saveAllColunmsArray{
    NSString *pathString = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    pathString = [pathString stringByAppendingPathComponent:@"Colunms/Colunms.plist"];
    
    
    
}
-(void)reloadView{
    colunmsButtonHeight = 40;
    colunmsButtonWidth = _scrolView.frame.size.width;
    CGRect frame = CGRectMake(0, 0, colunmsButtonWidth, colunmsButtonHeight);
    if (recommendArray.count > 0) {
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        [button setTitle:@"推荐" forState:UIControlStateNormal];

        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

        [button setBackgroundImage:[UIImage imageNamed:@"biz_pc_account_register_btn_normal.9"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"biz_pc_account_register_btn_pressed.9"] forState:UIControlStateSelected];

        [button setTintColor:[UIColor clearColor]];

        [button addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        button.selected = YES;
        button.tag = 10;
        [_scrolView addSubview:button];
        [buttonArray addObject:button];
        frame.origin.y += colunmsButtonHeight;
    }
    for (int i = 0; i < allColunmsArray.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        [button setTitle:((ColumnsListModel *)allColunmsArray[i]).cName forState:UIControlStateNormal];

        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

        [button setBackgroundImage:[UIImage imageNamed:@"biz_pc_account_register_btn_normal.9"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"biz_pc_account_register_btn_pressed.9"] forState:UIControlStateSelected];

        [button addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        [button setTintColor:[UIColor clearColor]];
        button.tag = 11 + i;
        [_scrolView addSubview:button];
        [buttonArray addObject:button];
        frame.origin.y += colunmsButtonHeight;

    }
    _scrolView.contentSize = CGSizeMake(colunmsButtonWidth, frame.origin.y);

//    NSLog(@"%@",_scrolView.subviews);
//    NSLog(NSStringFromCGSize(_scrolView.contentSize));
//    _scrolView.layer.borderWidth = 1;
//    _scrolView.layer.borderColor = [UIColor grayColor].CGColor;
//    _scrolView.layer.shadowOffset = CGSizeMake(-10, 0);
//    _scrolView.layer.shadowColor = [UIColor blackColor].CGColor;
//    _scrolView.layer.shadowRadius = 10;
//    _scrolView.layer.shadowOpacity = 0.6;

    dataArray = recommendArray;
    [_tableView reloadData];

    [MBProgressHUD hideHUDForView:_tableView.superview animated:YES];
}
#pragma mark- UITableViewDataSource中的方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _tableView) {
        return 1;
    }else{
        if (filterArray) {
            return filterArray.count;
        }else{
            return  0;
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
        return dataArray.count;
    }else{
        return ((ColumnsListModel *) filterArray[section]).tList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ColumnsListCell *cell = [tableView dequeueReusableCellWithIdentifier:kColumnsListCellKey];
    ColumnsModel *model;
    if (tableView == _tableView) {
        model = dataArray[indexPath.row];

    }else{
        model = ((ColumnsListModel *)filterArray[indexPath.section]).tList[indexPath.row];
    }
    cell.model = model;
    cell.rootViewController = self.rootViewController;
    return cell;
}

- (IBAction)gotoBackButtonClick:(UIButton *)sender {
    if (isSearching) {
        [UIView animateWithDuration:0.6 animations:^{
            effectView.alpha = 0;
            titleContrast.constant = 10;
        } completion:^(BOOL finished) {
            [effectView removeFromSuperview];
            effectView = nil;

            filterArray = nil;

            [_textField resignFirstResponder];
            isSearching = NO;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeTranslation(self.frame.size.width, 0);
        } completion:^(BOOL finished) {
            [self.superview removeFromSuperview];
        }];
    }
}

- (void)categoryButtonClick:(UIButton *)sender {
    for (UIButton *button in buttonArray) {
        button.selected = NO;
    }
    if (sender.tag == 10) {
        dataArray = recommendArray;
    }else{
        dataArray = ((ColumnsListModel *)allColunmsArray[sender.tag - 11]).tList;
    }
    sender.selected = YES;
    [_tableView reloadData];
}

//-(void)willMoveToWindow:(UIWindow *)newWindow{
//    if (filterTableView.superview != nil) {
//        [filterTableView reloadData];
//    }
//    [_tableView reloadData];
//}

- (IBAction)searckButtonClick:(UIButton *)sender{
    if (isSearching) {
        [_textField resignFirstResponder];
    }else{
        isSearching = YES;
        sender.enabled = NO;
        effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        effectView.frame = contentView.bounds;
        [contentView addSubview:effectView];
        [_textField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
        effectView.alpha = 0;

        [UIView animateWithDuration:0.6 animations:^{
            effectView.alpha = 0.9;
            titleContrast.constant = 10 + titleLabel.frame.size.width;
        } completion:^(BOOL finished) {
            sender.enabled = YES;
        }];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [effectView addSubview:filterTableView];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.text == nil ||[textField.text isEqualToString:@""]) {
        [self textFieldTextIsEmpty];
    }
}
-(void)textFieldTextIsEmpty{
    filterArray = allColunmsArray;
    [filterTableView reloadData];

}

- (void)textFieldTextChange:(UITextField *)textField {
    static NSString *lastString = nil;
    if (textField.text == lastString) {
        return;
    }
    lastString = textField.text;

    NSLog(@"text = %@",textField.text);
    if ([textField.text isEqualToString:@""]) {
        [self textFieldTextIsEmpty];
    }else{
        filterArray = [NSMutableArray new];
        for (ColumnsListModel *model in allColunmsArray) {
            NSArray *array = [NSArray arrayWithArray:model.tList];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.tname CONTAINS %@",textField.text];
             NSArray *result = [array filteredArrayUsingPredicate:predicate];
            if (result.count > 0) {
                ColumnsListModel *resultModel = [[ColumnsListModel alloc] init];
                resultModel.cName = model.cName;
                resultModel.tList = result;
                [filterArray  addObject:resultModel];
            }
        }
        [filterTableView reloadData];
    }
}
- (void)textFieldTextExit:(UITextField *)textField {
    [_textField resignFirstResponder];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}

@end
