//
//  RegisterVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/4.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "RegisterVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <RACSignal.h>
#import "Setting.h"
#import "UIColor+ColorAddtional.h"
#import "BusinessManager.h"
#import "CacheData.h"

@interface RegisterVC ()
@property (nonatomic)NSString* verifyCodeBtnTitle;
@property (nonatomic)NSTimer* timer;
@property (nonatomic)NSInteger lastSeconds;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSBundle mainBundle] loadNibNamed:@"Register" owner:self options:nil];
    self.verifyCodeBtnTitle = self.btnSendVerifyCode.titleLabel.text;
    RACSignal *emailSignal = [self.tfEmail.rac_textSignal map:^id(id value) {
        return @([self valideEmail:value]);
    }];
    [emailSignal subscribeNext:^(id x) {
        NSLog(@"here valid mail， %@", [[NSNumber alloc] initWithBool:[x boolValue]]);
        self.btnSendVerifyCode.enabled = [x boolValue];
        if(self.btnSendVerifyCode.enabled){
            self.btnSendVerifyCode.backgroundColor = [UIColor btnEnableColor];
        }else{
            self.btnSendVerifyCode.backgroundColor = [UIColor btnDisableColor];
        }
    }];
    [[self.btnSendVerifyCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.lastSeconds = 30;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSchedule) userInfo:nil repeats:YES];
        self.btnSendVerifyCode.enabled = NO;
        [self sendVerifyCode:self.tfEmail.text];
    }];
    
    RACSignal *passwordSignal = [self.tfPassword.rac_textSignal map:^id(NSString* value) {
        return @([value length] > 3);
    }];
    [passwordSignal subscribeNext:^(id x) {
        self.btnSure.enabled = [x boolValue];
        if(self.btnSure.enabled){
            self.btnSure.backgroundColor = [UIColor btnEnableColor];
        }else{
            self.btnSure.backgroundColor = [UIColor btnDisableColor];
        }
    }];
    
    [self.btnSure addTarget:self action:@selector(doSure:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)sendVerifyCode:(NSString*)email{
    [[BusinessManager shareManager] doRequest:@"SendVerifyCode" params:@{@"email":email} success:^(NSDictionary* value) {
        
    } failure:^(NSError *error) {
        //
    }];
}

-(void)doSure:(id)sender{
    [[BusinessManager shareManager] doRequest:@"Register" params:@{@"verify_code":self.tfVerifyCode.text, @"email":self.tfEmail.text, @"password":self.tfPassword.text} success:^(id value) {
        NSInteger code = [[value valueForKey:@"code"] integerValue];
        NSString *message = [value valueForKey:@"message"];
        NSDictionary* user = [value valueForKey:@"data"];
        if (code != 0) {
            self.lbErrorMes.text = message;
            self.lbErrorMes.hidden = NO;
        }else{
            self.lbErrorMes.hidden = YES;
            [CacheData setUsers:KEY_USER_EMAIL value:self.tfEmail.text];
            [CacheData setUsers:KEY_USER_PASSWORD value:self.tfPassword.text];
            [CacheData setUsers:KEY_USER_ID value:[user valueForKey:@"userid"]];
            [CacheData setUsers:KEY_STATUS_LOGIN value:VALUE_STATUS_LOGIN];
            [CacheData setUsers:KEY_USER_NAME value:self.tfEmail.text];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        //
    }];
}

-(void)timerSchedule{
    self.lastSeconds = self.lastSeconds - 1;
    [self.btnSendVerifyCode setTitle:[[NSString alloc] initWithFormat:@"%ld(s)", (long)self.lastSeconds] forState:UIControlStateNormal];
    if (self.lastSeconds == 0) {
        [self.btnSendVerifyCode setTitle:self.verifyCodeBtnTitle forState:UIControlStateNormal];
        [self.timer invalidate];
        self.btnSendVerifyCode.enabled = YES;
    }
}

-(BOOL)valideEmail:(NSString*)email{
    NSLog(@"email:%@, %@", email, [[NSNumber alloc] initWithBool:[Setting checkEmailValid:email]]);
    return [Setting checkEmailValid:email];
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
