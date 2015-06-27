//
//  DetailViewController.m
//  NeteasyNews
//
//  Created by 004 on 15/6/6.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentView.h"
#import "AFNetworking.h"
#import "NewsModel.h"
#import "Network.h"
#import "VideoPlayer.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "UIView+ToastView.h"




@interface DetailViewController ()<UIWebViewDelegate>
{
    __weak IBOutlet UIImageView *imageView;
    DetailNewsModel *detailModel;
    __weak IBOutlet UILabel *sourceLabel;
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet NSLayoutConstraint *titleViewHeight;
    __weak IBOutlet NSLayoutConstraint *tabBarHeight;
    __weak IBOutlet UIView *titleView;
    __weak IBOutlet UIView *containerView;


    __weak IBOutlet UIView *videoContainerView;
    __weak IBOutlet UIView *pictureContainerView;


    __weak IBOutlet NSLayoutConstraint *picHeight;

}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;

@end

@implementation DetailViewController
{

}
- (void)viewDidLoad {
    [super viewDidLoad];

    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    if (self.tabBarController != nil) {
        tabBarHeight.constant = self.tabBarController.tabBar.frame.size.height;
    }else{
        tabBarHeight.constant = 0;
    }

    if(self.navigationController == nil){
        titleViewHeight.constant = 60;
        titleView.hidden = NO;

    }else{
        titleViewHeight.constant = 0;
        titleView.hidden = YES;
    }
    imageView.image = [[UIImage imageNamed:@"biz_pic_item_bg.9.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    containerView.superview.hidden = YES;

    [self sendRequestUsingAFNetworking:_parameterDictionary];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendRequestUsingAFNetworking:(NSDictionary *)dic{

    NSString *docid;
    if (dic[kdocidKey] == nil) {
        NewsModel *newsModel = dic[kNewsModelKey];
        docid = newsModel.docid;
    }else{
        docid = dic[kdocidKey];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",docid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        detailModel = [DetailNewsModel getDetailNewsModel:response][0];

        titleLabel.text = detailModel.title;
        sourceLabel.text = detailModel.source;
        timeLabel.text = detailModel.ptime;
        NSString *string = detailModel.body;
        NSLog(@"HTML = %@",string);
        [_webView loadHTMLString:string baseURL:nil];

        if (detailModel.replyBoard == nil || detailModel.docid == nil) {
            [containerView.superview removeFromSuperview];
            [imageView removeFromSuperview];
        }else{
            [self loadCommentView];

        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void)loadCommentView{
    NSString *API = @"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/5/10/2/2";

    NSString *replyBoard = detailModel.replyBoard;
    NSString *docid = detailModel.docid;
    NSString *url = [NSString stringWithFormat:API,replyBoard,docid];
    NSLog(@"url ==%@",url);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [Network GetDataFromAFNetworkingWithURL:url CallBack:^(id responseObject) {
        NSArray *array = [CommentModel getCommentModel:responseObject];
        if (array.count == 0) {
            [containerView.superview removeFromSuperview];
            [imageView removeFromSuperview];
        }
        containerView.superview.hidden = NO;
        for (int i = 0; i < 2; i ++) {
            CommentView *commentView = (CommentView *)[containerView viewWithTag:10 + i];

            if (i >= array.count) {
                [commentView removeFromSuperview];
            }else{
                [commentView setModel:array[i]];
            }
        }
    }];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    webView.scrollView.bounces = NO;
    webView.scrollView.alwaysBounceVertical = NO;
    webView.scrollView.alwaysBounceHorizontal = NO;
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
    [webView stringByEvaluatingJavaScriptFromString:meta];

    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:
                                                     @"var script = document.createElement('script');"
                                                     "script.type = 'text/javascript';"
                                                     "script.text = \"function ResizeImages() { "
                                                     "var myimg,oldwidth;"
                                                     "var maxwidth = %f;" // UIWebView中显示的图片宽度
                                                     "for(i=0;i <document.images.length;i++){"
                                                     "myimg = document.images[i];"
                                                     "if(myimg.width > maxwidth){"
                                                     "oldwidth = myimg.width;"
                                                     "myimg.width = maxwidth;"
                                                     "}"
                                                     "}"
                                                     "}\";"
                                                     "document.getElementsByTagName('head')[0].appendChild(script);",webView.frame.size.width - 20]];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];

    float htmlHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    _webViewHeight.constant = htmlHeight;


    [webView layoutIfNeeded];
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
-(void)setModel:(DetailNewsModel *)model{

}

- (IBAction)gotoBackButtonClick:(id)sender {
    if(self.navigationController == nil){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
