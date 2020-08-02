//
//  HYProtocalViewController.m
//  youbaner
//
//  Created by luzhongchang on 2017/9/21.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYProtocalViewController.h"

@interface HYProtocalViewController ()
@property(nonatomic ,strong)WKWebView * webView;
@end

@implementation HYProtocalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.canBack =YES;
    

    self.navigationItem.title=@"软件服务协议";
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"InformedConset"
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [webView loadHTMLString:htmlCont baseURL:baseURL ];
    [self.view addSubview:webView];

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
