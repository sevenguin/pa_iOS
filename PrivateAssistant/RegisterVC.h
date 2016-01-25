//
//  RegisterVC.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/4.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfVerifyCode;
@property (weak, nonatomic) IBOutlet UIButton *btnSendVerifyCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak, nonatomic) IBOutlet UILabel *lbErrorMes;

@end
