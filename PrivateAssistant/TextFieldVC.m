//
//  TextFieldVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/6.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "TextFieldVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <RACSignal.h>
#import "UIColor+ColorAddtional.h"
#import "BusinessManager.h"
#import "CacheData.h"

@interface TextFieldVC ()

@end

@implementation TextFieldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSBundle mainBundle] loadNibNamed:@"TextFieldVC" owner:self options:nil];
    RACSignal* nicknameSiganal = [self.tfNickname.rac_textSignal map:^id(id value) {
        return @([value length] > 3);
    }];
    [nicknameSiganal subscribeNext:^(NSNumber* nickNameValid) {
        if ([nickNameValid boolValue]) {
            self.btnSure.enabled = YES;
            self.btnSure.backgroundColor = [UIColor btnEnableColor];
        }else{
            self.btnSure.enabled = NO;
            self.btnSure.backgroundColor = [UIColor btnDisableColor];
        }
    }];
    self.tfErrorCode.hidden = YES;
    [self.btnSure addTarget:self action:@selector(doSure:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doSure:(id)sender{
    if ([self.actionStr isEqualToString:@"nickname"]) {
        [[BusinessManager shareManager] doRequest:@"SetNickName" params:@{@"nickname":self.tfNickname.text, @"userid":[[CacheData getUsers] valueForKey:@"userid"]} success:^(id value) {
            NSString* message = [value valueForKey:@"message"];
            NSInteger code = [[value valueForKey:@"code"] integerValue];
            if (code == 0) {
                [CacheData setUsers:KEY_USER_NAME value:self.tfNickname.text];
            }else{
                self.tfErrorCode.text = message;
                //NSLog(@"failed");
            }
            self.tfNickname.text = @"";
            self.tfErrorCode.hidden = YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            self.tfErrorCode.text = @"设置失败";
            self.tfErrorCode.hidden = NO;
        }];
    }
}

@end
