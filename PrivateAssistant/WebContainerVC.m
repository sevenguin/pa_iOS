//
//  WebContainerVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/8.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "WebContainerVC.h"
#import "Configure.h"

@interface WebContainerVC ()

@end

@implementation WebContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSBundle mainBundle] loadNibNamed:@"WebContainerVC" owner:self options:nil];
    self.webView.delegate = self;
    NSString* htmlName = [[Configure getSettingMenuHtml] objectForKey:self.menu];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *error = nil;
    NSString *html = [[NSString alloc]initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&error];
    if(error == nil){
        [self.webView loadHTMLString:html baseURL:bundleUrl];
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"web view did loaded. html:\n%@", [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
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
