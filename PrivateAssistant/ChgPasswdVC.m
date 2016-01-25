//
//  ChgPasswdVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/3.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "ChgPasswdVC.h"
#import "BusinessManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Setting.h"

@interface ChgPasswdVC()

@property (nonatomic)NSString* verifyCode;
@property (nonatomic)NSTimer* timer;
@property (nonatomic)NSInteger lastSeconds;
@property (nonatomic)NSString* verifyCodeBtnTitle;

@end

@implementation ChgPasswdVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSBundle mainBundle] loadNibNamed:@"ChgPasswd" owner:self options:nil];
    self.verifyCodeBtnTitle = self.btnSendValidCode.titleLabel.text;
    RACSignal *emailSignal = [self.tfEmail.rac_textSignal map:^id(id value) {
        return @([self valideEmail:value]);
    }];
    [emailSignal subscribeNext:^(id x) {
        self.btnSendValidCode.enabled = [x boolValue];
    }];
    
    RACSignal *validCodeSingal = self.tfValidCode.rac_textSignal;
                                  
    [[self.btnSendValidCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self sendVerfyCode:self.tfEmail.text signal:validCodeSingal];
        self.lastSeconds = 30;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSchedule) userInfo:nil repeats:YES];
        self.btnSendValidCode.enabled = NO;
    }];
    
    RACSignal *btnSure = [RACSignal combineLatest:@[emailSignal, validCodeSingal] reduce:^id(NSNumber* emailValid, NSNumber* verifyCodeValid){
        return @([emailValid boolValue] && [verifyCodeValid boolValue]);
    }];
    [btnSure subscribeNext:^(id x) {
        self.btnSure.enabled = YES;
    }];
}

-(void)sendVerfyCode:(NSString*)email signal:(RACSignal*)signal{
    [[BusinessManager shareManager] doRequest:nil params:nil success:^(id value) {
        self.verifyCode = value;
        [signal map:^id(id value) {
            return @([self validVerifyCode:value]);
        }];
    } failure:^(NSError *error) {
        //
    }];
}

-(BOOL)validVerifyCode:(NSString*)verifyCode{
    //这个应该是点击之后再触发的信号
    if ([verifyCode isEqualToString:self.verifyCode]) {
        return YES;
    }else{
        return NO;
    }
}

-(void)timerSchedule{
    self.lastSeconds = self.lastSeconds - 1;
    [self.btnSendValidCode setTitle:[[NSString alloc] initWithFormat:@"%ld(s)", (long)self.lastSeconds] forState:UIControlStateNormal];
    if (self.lastSeconds == 0) {
        [self.btnSendValidCode setTitle:self.verifyCodeBtnTitle forState:UIControlStateNormal];
        [self.timer invalidate];
        self.btnSendValidCode.enabled = YES;
    }
}

-(BOOL)valideEmail:(NSString*)email{
    return [Setting checkEmailValid:email];
}

@end
