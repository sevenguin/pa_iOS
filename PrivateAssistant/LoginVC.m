//
//  LoginVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/2.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "LoginVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <RACSignal.h>
#import "BusinessManager.h"
#import "ChgPasswdVC.h"
#import "RegisterVC.h"
#import "UIColor+ColorAddtional.h"
#import "CacheData.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSBundle mainBundle] loadNibNamed:@"Login" owner:self options:nil];
    
    self.lbErrorCode.text = @"";
    RACSignal *usernameSignal = [self.userName.rac_textSignal map:^id(NSString* value) {
        return @([value length] > 3);
    }];
    RACSignal *passwordSignal = [self.password.rac_textSignal map:^id(NSString* value) {
        return @([value length] > 3);
    }];
    RACSignal *signUpSignal = [RACSignal combineLatest:@[usernameSignal, passwordSignal] reduce:^id(NSNumber* usernameValid, NSNumber *passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    [signUpSignal subscribeNext:^(NSNumber* signUpActive) {
        self.btnSure.enabled = [signUpActive boolValue];
        if (self.btnSure.enabled) {
            self.btnSure.backgroundColor = [UIColor btnEnableColor];
        }else{
            self.btnSure.backgroundColor = [UIColor btnDisableColor];
        }
    }];
    [[self.btnSure rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"sign up is pressed");
        [self doSignIn:nil];
    }];
    [[self.btnForgetPwd rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self doForgetPwd:nil];
    }];
    [[self.btnRegister rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self doRegister:nil];
    }];
}
-(void)doForgetPwd:(id)sender{
    ChgPasswdVC *chgPasswd = [[ChgPasswdVC alloc] init];
    [chgPasswd.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:chgPasswd animated:YES];
}

-(void)doRegister:(id)sender{
    RegisterVC *registerVC = [[RegisterVC alloc] init];
    [registerVC.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:registerVC animated:YES];
}
//这段代码应该放在MV中？
-(void)doSignIn:(id)sender{
    [[BusinessManager shareManager] doRequest:@"Login" params:@{@"email":self.userName.text, @"password":self.password.text} success:^(NSDictionary* value) {
        NSString* message = [value valueForKey:@"message"];
        NSInteger code = [[value valueForKey:@"code"] integerValue];
        NSDictionary* user = [value valueForKey:@"data"];
        if (code == 0) {
            [CacheData setUsers:KEY_USER_EMAIL value:self.userName.text];
            [CacheData setUsers:KEY_USER_PASSWORD value:self.password.text];
            [CacheData setUsers:KEY_STATUS_LOGIN value:VALUE_STATUS_LOGIN];
            [CacheData setUsers:KEY_USER_NAME value:[user valueForKey:@"nickname"]];
            [CacheData setUsers:KEY_USER_ID value:[user valueForKey:@"userid"]];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            self.lbErrorCode.text = message;
            //NSLog(@"failed");
        }
    } failure:^(NSError *error) {
        //
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
