//
//  WebContainerVC.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/8.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebContainerVC : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic)NSString *menu;

@end
