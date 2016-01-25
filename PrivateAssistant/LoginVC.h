//
//  LoginVC.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/2.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
//<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak, nonatomic) IBOutlet UIButton *btnForgetPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UILabel *lbErrorCode;

@property (nonatomic, weak) IBOutlet UIView *referenceView;


@end
