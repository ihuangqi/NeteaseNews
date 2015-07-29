//
//  WebViewController.m
//  NeteasyNews
//
//  Created by 004 on 15/6/16.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //self.view.frame = [UIScreen mainScreen].bounds;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    view.backgroundColor = [UIColor redColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 30, 35)];
    [button setImage:[UIImage imageNamed:@"biz_audio_list_btn_download_cancel"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60)];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [webView loadRequest:request];
    [MBProgressHUD showHUDAddedTo:webView animated:YES];
    // htmlBody = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
    // [webView loadHTMLString:htmlBody baseURL:nil];
    //    [webView scalesPageToFit];

    [self.view addSubview:view];
    [self.view addSubview:webView];





    // Do any additional setup after loading the view.
}

- (void)backButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize viewSize = webView.bounds.size;

    float rw = viewSize.width / contentSize.width;
    webView.scrollView.minimumZoomScale = rw;
    webView.scrollView.maximumZoomScale = rw;
    webView.scrollView.zoomScale = rw;
    //    webView.scrollView.contentSize = CGSizeMake(viewSize.width, contentSize.height * rw);
    webView.scrollView.alwaysBounceHorizontal = NO;
    webView.scrollView.alwaysBounceVertical = NO;
    webView.scrollView.bounces = NO;
    
    //    //修改服务器页面的meta的值
    //    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
    //    [webView stringByEvaluatingJavaScriptFromString:meta];

    //    //给网页增加utf-8编码
    //    [webView stringByEvaluatingJavaScriptFromString:
    //     @"var tagHead =document.documentElement.firstChild;"
    //     "var tagMeta = document.createElement(\"meta\");"
    //     "tagMeta.setAttribute(\"http-equiv\", \"Content-Type\");"
    //     "tagMeta.setAttribute(\"content\", \"text/html; charset=utf-8\");"
    //     "var tagHeadAdd = tagHead.appendChild(tagMeta);"];

    //    //给网页增加css样式
    //    [webView stringByEvaluatingJavaScriptFromString:
    //     @"var tagHead =document.documentElement.firstChild;"
    //     "var tagStyle = document.createElement(\"style\");"
    //     "tagStyle.setAttribute(\"type\", \"text/css\");"
    //     "tagStyle.appendChild(document.createTextNode(\"BODY{padding: 20pt 15pt}\"));"
    //     "var tagHeadAdd = tagHead.appendChild(tagStyle);"];
    //
    //    //拦截网页图片  并修改图片大小
    //    [webView stringByEvaluatingJavaScriptFromString:
    //     @"var script = document.createElement('script');"
    //     "script.type = 'text/javascript';"
    //     "script.text = \"function ResizeImages() { "
    //     "var myimg,oldwidth;"
    //     "var maxwidth=380;" //缩放系数
    //     "for(i=0;i <document.images.length;i++){"
    //     "myimg = document.images[i];"
    //     "if(myimg.width > maxwidth){"
    //     "oldwidth = myimg.width;"
    //     "myimg.width = maxwidth;"
    //     "myimg.height = myimg.height * (maxwidth/oldwidth);"
    //     "}"
    //     "}"
    //     "}\";"
    //     "document.getElementsByTagName('head')[0].appendChild(script);"];
    //
    //    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    [MBProgressHUD hideHUDForView:webView animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
