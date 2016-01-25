//
//  ChgPasswdVC.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/3.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChgPasswdVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfValidCode;
@property (weak, nonatomic) IBOutlet UIButton *btnSendValidCode;
@property (weak, nonatomic) IBOutlet UITextField *tfNewPasswd;
//@property (weak, nonatomic) IBOutlet UITextField *tfSureNewPasswd;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;

@property (nonatomic, weak) IBOutlet UIView *referenceView;

@end
