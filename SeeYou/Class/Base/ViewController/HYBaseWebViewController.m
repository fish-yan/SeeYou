//
//  HYBaseWebViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseWebViewController.h"
#import <WebKit/WebKit.h>
//#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>


@interface HYBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIView *progressView;

@end

@implementation HYBaseWebViewController

+ (void)load {
    [self mapAsBaseWebViewWithName:kModuleWebView andParams:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self observeValues];
    [self loadWebView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)loadWebView {
    
    /** start 添加无网络展示页面**/
//    @weakify(self);
//    [self.view hiddenFailureView];
//    if(![WDNetworkTools shareTools].isReachable)
//    {
//        
//        [self.view showFailureViewOfType:WDFailureViewTypeUnreachabel withClickAction:^{
//            @strongify(self);
//            [self.view hiddenFailureView];
//            [self loadWebView];
//        }];
//        return;
//    }
//    
    /** end 添加无网络展示页面**/
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60];
//    [WDSignatureManager addHeader:request params:nil method:WDRequestTypeGET url:self.url isURLHaveAPITag:NO];
    [self.webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化WebView

- (void)initialize {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    //    config.allowsInlineMediaPlayback = YES;
    //    config.allowsPictureInPictureMediaPlayback = YES;
    //    config.allowsAirPlayForMediaPlayback = YES;
    
    WKPreferences *prefrences = [[WKPreferences alloc] init];
    //prefrences.minimumFontSize = 13.0;
    prefrences.javaScriptEnabled = YES;
    prefrences.javaScriptCanOpenWindowsAutomatically = NO;
    
    config.preferences = prefrences;
    
    //
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    
    [self.view addSubview:self.webView];
}


#pragma mark - Observe

- (void)observeValues {
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([object isKindOfClass:[WKWebView class]]) {
        WKWebView *webView = (WKWebView *)object;
        [self setProgressViewDisplayWithProgress:webView.estimatedProgress];
    }
}

- (void)setProgressViewDisplayWithProgress:(CGFloat)estimatedProgress {
    self.progressView.width = estimatedProgress * SCREEN_WIDTH;
}

#pragma mark - Other

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


#pragma mark - Lazy Loading

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
        _progressView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_progressView];
    }
    return _progressView;
}



#pragma mark - WebView Delegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self showProgressView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self hiddenProgressView];
    
    self.navigationItem.title = webView.title;
    //    [webView evaluateJavaScript:@"document.title"
    //              completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    //                  if (error == nil && result) {
    //                      self.navigationItem.title = result;
    //                  }
    //              }];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self hiddenProgressView];
}


#pragma mark - Action

- (void)hiddenProgressView {
    self.progressView.hidden = YES;
}

- (void)showProgressView {
    self.progressView.hidden = NO;
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
