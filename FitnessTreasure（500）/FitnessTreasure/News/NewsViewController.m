//
//  NewsViewController.m
//  FitnessTreasure
//
//  Created by buyun-wutao on 2018/7/26.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "NewsViewController.h"
#define baseURl @"http://www.wutt.vip"


@interface NewsViewController ()<UIWebViewDelegate>
@property (nonatomic ,strong) UIWebView *WebView;
@property (nonatomic ,strong) UILabel *lab;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"News";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    _WebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, fScreenW, fScreenH)];
    [self.view addSubview:_WebView];
    NSURL *url=[NSURL URLWithString:baseURl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_WebView loadRequest:request];
    _WebView.delegate = self;
    // 3）是否与用户交互（即用户能不能控制webview）
    [_WebView setUserInteractionEnabled:YES];
    [SVProgressHUD showWithStatus:@"加载中..."];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
-(void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}
@end
