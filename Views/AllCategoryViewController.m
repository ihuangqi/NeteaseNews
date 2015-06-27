//
//  AllCategoryView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/19.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "AllCategoryViewController.h"
#import "CategoryModel.h"
#import "CategoryCell.h"

#import "LXReorderableCollectionViewFlowLayout.h"
#import "AllCategoryFooterView.h"
#import "AllCategoryHeaderView.h"


#define kAllCategoryFooterViewIdentifier @"AllCategoryFooterView"
#define kAllCategoryHeaderViewIdentifier @"AllCategoryHeaderView"

@interface AllCategoryViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LXReorderableCollectionViewDataSource, LXReorderableCollectionViewDelegateFlowLayout>
{
    NSMutableArray *dataSourceArray;
    UICollectionViewFlowLayout *layout;

    NSIndexPath *_toIndexPath;
    NSIndexPath *_fromIndexPath;
}

@end

@implementation AllCategoryViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (instancetype)init
{
    layout = [[LXReorderableCollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        // 2.设置每个格子的尺寸
        layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width / 4) - 8, 40);
        // 3.设置整个collectionView的内边距
        CGFloat paddingY = 5;
        CGFloat paddingX = 0;
        layout.sectionInset = UIEdgeInsetsMake(paddingY, paddingX, paddingY, paddingX);
        // 4.设置每一行之间的间距
        layout.minimumLineSpacing = paddingY;
        layout.minimumInteritemSpacing = paddingY;

        [self.collectionView registerClass:[CategoryCell class] forCellWithReuseIdentifier:@"CategoryCell"];
        self.collectionView.backgroundColor = [UIColor colorWithRed:0.996 green:0.992 blue:0.996 alpha:1.000];

        self.collectionView.allowsMultipleSelection = NO;

        [self.collectionView registerClass:[AllCategoryFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kAllCategoryFooterViewIdentifier];
        [self.collectionView registerClass:[AllCategoryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kAllCategoryHeaderViewIdentifier];

    }
    return self;
}
-(void)initButton{

}
-(void)viewDidLoad{
    dataSourceArray = [CategoryModel GetAllModel];

    UIView *view = self.view.superview;
    UIButton *catrgroyArrowButton = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width - 30 + 5, 5, 20, 20)];
    [catrgroyArrowButton setBackgroundImage:[UIImage imageNamed:@"night_biz_tie_comment_expand_arrow"] forState:UIControlStateNormal];
    [catrgroyArrowButton addTarget:self action:@selector(catrgroyArrowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    catrgroyArrowButton.tag = HQCatrgroyArrowButtonTag;
    [view addSubview:catrgroyArrowButton];
    [view bringSubviewToFront:catrgroyArrowButton];

    CGRect frame = view.frame;
    frame.size.height = 20;
    view.frame = frame;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = view.frame;
        frame.size.height = self.view.frame.size.height;
        view.frame = frame;
        catrgroyArrowButton.transform = CGAffineTransformMakeRotation(M_PI);
    }];


}
- (void)catrgroyArrowButtonClick:(UIButton *)catrgroyArrowButton {
    UIView *view = self.view.superview;
    [CategoryModel writeToFile];
//    [self categoryButtonClick:(UIButton *)[self.view viewWithTag:allCategoryVC.selectedIndex + HQCategoryButtonFirstTag]];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGRect frame = view.frame;
        frame.size.height = 20;
        view.frame = frame;
        catrgroyArrowButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}
#pragma mark - 数据源方法
/**
 *  第section组有多少个格子（cell）
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataSourceArray.count;
}

//每个格子的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifiy = @"CategoryCell";

    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifiy forIndexPath:indexPath];
    CategoryModel *model = dataSourceArray[indexPath.row];
    [cell setModel:model];
    if (model.isSelected == YES) {
        [cell setSelected:YES];
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }else{
        [cell setSelected:NO];
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size={self.collectionView.frame.size.width,20};
    return size;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={self.collectionView.frame.size.width,30};
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath {

}
-(void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath{
    CategoryModel *model = dataSourceArray[fromIndexPath.row];
    [dataSourceArray removeObjectAtIndex:fromIndexPath.row];
    [dataSourceArray insertObject:model atIndex:toIndexPath.row];

}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath {
    if (toIndexPath.row == 0) {
        return NO;
    }
    return YES;
}


#pragma mark - LXReorderableCollectionViewDelegateFlowLayout methods
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    _fromIndexPath = indexPath;
    NSLog(@"indexPath={%ld}",indexPath.row);
    NSLog(@"will begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath={%ld}",indexPath.row);
    NSLog(@"did begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath={%ld}",indexPath.row);
    NSLog(@"will end drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    _toIndexPath = indexPath;
    [_newsVC newsViewMoveToIndex:_toIndexPath.row FromIndex:_fromIndexPath.row];
    [self.collectionView reloadData];
    NSLog(@"indexPath={%ld}",indexPath.row);
    NSLog(@"did end drag");
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryModel *model = dataSourceArray[indexPath.row];
    [CategoryModel setSelectedModel:model];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;

    if([kind isEqual:UICollectionElementKindSectionFooter]){
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kAllCategoryFooterViewIdentifier forIndexPath:indexPath];
    }else if ([kind isEqual:UICollectionElementKindSectionHeader]){
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kAllCategoryHeaderViewIdentifier forIndexPath:indexPath];
    }
    return view;
}

-(NSInteger)selectedIndex{
    NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
    return selectedIndexPath.row;
}


@end
