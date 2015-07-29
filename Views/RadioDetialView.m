//
//  RadioPlayView.m
//  NeteasyNews
//
//  Created by 004 on 15/6/12.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "RadioDetialView.h"
#import "RadioTemplateModel.h"
#import "RadioDetailModel.h"
#import "RadioObjectModel.h"
#import "Network.h"
#import "RadioListModel.h"
#import "RadioPlayer.h"
#import "RadioDetialTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DownloadManager.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

#define DetailAPI @"http://c.3g.163.com/nc/article/%@/full.html"
#define ListAPI @"http://c.3g.163.com/nc/article/list/%@/%d-%d.html"





#define kRadioDetialTableViewCellKey @"RadioDetialTableViewCell"
static RadioPlayer *player;
@interface RadioDetialView()<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>

@end
@implementation RadioDetialView
{
    int playIndex;
    __weak IBOutlet UIImageView *_imageView;
    RadioDetailModel *radioDetailModel;

    NSMutableArray *dataArray;
    __weak IBOutlet UITableView *_tableView;
    BOOL isPlaying;

    __weak IBOutlet UIImageView *backIconView;
    __weak IBOutlet UILabel *playedTimeLabel;

    __weak IBOutlet UISlider *srollProgressView;
    __weak IBOutlet UILabel *totalTimeLabel;

    __weak IBOutlet UIImageView *playButtonImageView;

    __weak IBOutlet UILabel *titleLabel;

    RadioListModel *topListModel;


    MJRefreshHeaderView *headerView;

    BOOL isRequesting;

    int startPage;
    int pageCount;
    NSString *tid;

}

//http://c.3g.163.com/nc/article/ARVMG36500964KLQ/full.html

//http://c.3g.163.com/nc/article/list/T1379040077136/0-20.html


-(void)awakeFromNib{
    playIndex = 0;
    _imageView.layer.cornerRadius = _imageView.frame.size.width / 2;
    _imageView.layer.borderWidth = 10;
    _imageView.layer.borderColor = [UIColor colorWithWhite:0.200 alpha:0.800].CGColor;
    [_tableView registerNib:[UINib nibWithNibName:@"RadioDetialTableViewCell" bundle:nil] forCellReuseIdentifier:kRadioDetialTableViewCellKey];

    headerView = [[MJRefreshHeaderView alloc] initWithScrollView:_tableView];
    headerView.delegate =self;
    
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    startPage = 0;
    [self getDataSource];
}
- (IBAction)backButtonClick:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(self.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];
}
#pragma mark- UITableViewDataSource中的方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([dataArray[indexPath.row] isKindOfClass:[RadioDetailModel class]]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        }
        cell.textLabel.text = [((RadioDetailModel *)dataArray[indexPath.row]) title];
        return cell;
    }
    RadioDetialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRadioDetialTableViewCellKey];
    RadioListModel *model = dataArray[indexPath.row];
    [cell setModel:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    playIndex = (int)indexPath.row;
    if ([dataArray[indexPath.row] isKindOfClass:[RadioDetailModel class]]) {
        radioDetailModel = dataArray[indexPath.row];
        [self playTheRadio];
        return;
    }

    topListModel.isTop = NO;
    [topListModel.cell loadView];
    RadioListModel *radioListModel = dataArray[indexPath.row];
    NSString *docid = radioListModel.docid;
    [Network GetDataFromAFNetworkingWithURL:[NSString stringWithFormat:DetailAPI,docid] CallBack:^(id responseObject) {
        radioDetailModel = [[RadioDetailModel alloc] initWithDictionary:responseObject];
        if ([[DownloadManager sharedManager] getDownloadedObjectForDocid:radioListModel.docid]) {
            radioDetailModel.downloadObject = [[DownloadManager sharedManager] getDownloadedObjectForDocid:radioDetailModel.docid];
        }
        [self playTheRadio];
    }];
    topListModel = radioListModel;
    topListModel.isTop = YES;
    [topListModel.cell loadView];
//    [tableView reloadData];

}

-(void)playTheRadio{

    titleLabel.text = radioDetailModel.source;
    [backIconView sd_setImageWithURL:[NSURL URLWithString:radioDetailModel.video.cover] placeholderImage:[UIImage imageNamed:@"biz_audio_play_header_column_cover_default"]];

    if (radioDetailModel.downloadObject) {

        player = [RadioPlayer getPlayerWithURL:radioDetailModel.downloadObject.fileURL];
    }else{
        player = [RadioPlayer getPlayerWithURL:[NSURL URLWithString:radioDetailModel.video.url_m3u8]];
    }
    player.sliderView = srollProgressView;
    player.playTimeLabel = playedTimeLabel;
    player.totalTimeLabel = totalTimeLabel;
    isPlaying = YES;

    [self setPlayButtonImageViewImage:playButtonImageView];
}
-(void)setParameterDictionary:(NSDictionary *)parameterDictionary{
    if (parameterDictionary[kLoctionRadioKey]) {
        dataArray = parameterDictionary[kLoctionRadioKey];
        titleLabel.text = @"我的下载";
        if (dataArray.count > 0) {
            [_tableView reloadData];
        }
    }

    _parameterDictionary = parameterDictionary;
    RadioTemplateModel* radioTemplateModel = _parameterDictionary[@"RadioTemplateModel"];
    if (radioTemplateModel) {
        NSString *docid = radioTemplateModel.radio.docid;

        [Network GetDataFromAFNetworkingWithURL:[NSString stringWithFormat:DetailAPI,docid] CallBack:^(id responseObject) {
            radioDetailModel = [[RadioDetailModel alloc] initWithDictionary:responseObject];
            [self playTheRadio];
        }];

        tid = radioTemplateModel.tid;
        startPage = 0;
        pageCount = 20;
        dataArray = [NSMutableArray new];
        [self getDataSource];
    }
}

-(void)getDataSource{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    isRequesting = YES;
    [Network GetDataFromAFNetworkingWithURL:[NSString stringWithFormat:ListAPI,tid,startPage,pageCount] CallBack:^(id responseObject) {
        if(startPage == 0){
            [dataArray removeAllObjects];
        }
        [dataArray addObjectsFromArray:[RadioListModel getRadioListModeArrayFromResponse:responseObject]];
        if (dataArray.count > 0 && startPage == 0) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                while (!radioDetailModel && self.superview) {
                    [NSThread sleepForTimeInterval:1];
                }
                for (RadioListModel *listModel in dataArray) {
                    if ([listModel.docid isEqualToString:radioDetailModel.docid]) {
                        listModel.isTop = YES;
                        topListModel = listModel;
                        playIndex = (int)[dataArray indexOfObject:listModel];
                    }
                    if ([[DownloadManager sharedManager] getDownloadedObjectForDocid:listModel.docid]) {

                        listModel.downloadState = DownloadDone;

                    }

                }
                [_tableView reloadData];
            });
        }
        [_tableView reloadData];
        [headerView endRefreshing];
        isRequesting = NO;
        [MBProgressHUD hideHUDForView:self animated:YES];
    }];
}

- (IBAction)playDidTap:(UITapGestureRecognizer *)sender {
    isPlaying =!isPlaying;
    [self setPlayButtonImageViewImage:playButtonImageView];
    [[RadioPlayer sharedPlayer] playOrPause];
}
-(void)setPlayButtonImageViewImage:(UIImageView *)imageView{
    if (isPlaying) {
        imageView.image = [UIImage imageNamed:@"night_biz_audio_btn_pause"];
    }else{
        imageView.image = [UIImage imageNamed:@"night_biz_audio_btn_play"];
    }
}

- (IBAction)playPrevious:(id)sender {
    if (playIndex == 0) {
        return;
    }
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:playIndex - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:playIndex - 1 inSection:0]];
}
- (IBAction)playNext:(id)sender {
    if (playIndex == dataArray.count - 1) {
        return;
    }
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:playIndex + 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:playIndex + 1 inSection:0]];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _tableView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height + 10) {
            if (isRequesting == NO) {
                isRequesting = YES;
                startPage += 20;
                [self getDataSource];
            }
        }
    }
}
-(void)dealloc{
    [_tableView removeObserver:headerView forKeyPath:@"contentOffset"];
    headerView.delegate = nil;
    headerView = nil;
    
}
@end
