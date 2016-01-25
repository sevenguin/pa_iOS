//
//  TextFieldVC.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/6.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldVC : UIViewController
@property (nonatomic)NSString* actionStr;
@property (weak, nonatomic) IBOutlet UITextField *tfNickname;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak, nonatomic) IBOutlet UILabel *tfErrorCode;

@end
