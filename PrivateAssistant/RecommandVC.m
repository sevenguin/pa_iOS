//
//  RecommandVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 15/12/28.
//  Copyright © 2015年 weill. All rights reserved.
//

#import "RecommandVC.h"
#import "UIColor+ColorAddtional.h"
#import "TalkToolBar.h"
#import "MessageCell.h"
#import "UIColor+ColorAddtional.h"
#import "BusinessManager.h"
#import "Question.h"
#import "CommonTools.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import <RACSignal.h>

@interface RecommandVC ()
@property (nonatomic)NSMutableArray* messages;
@property (nonatomic)UITextField* tfMessage;
@property (nonatomic)CGFloat rowHeight;
@property (nonatomic)Question* curQuestion;
@end

@implementation RecommandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.messages = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor navigateBarColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    TalkToolBar* talkToolBar = [TalkToolBar toolBar];
    CGFloat y = [UIScreen mainScreen].bounds.size.height - talkToolBar.frame.size.height;
    talkToolBar.frame = CGRectMake(0, y, [UIScreen mainScreen].nativeBounds.size.width, talkToolBar.frame.size.height);
    talkToolBar.backgroundColor = [UIColor btnEnableColor];
    [((UIButton*)talkToolBar.subviews[4]) addTarget:self action:@selector(doSend:) forControlEvents:UIControlEventTouchUpInside];
    self.tfMessage = ((UITextField*)talkToolBar.subviews[3]);
    self.tfMessage.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor cellBackColor];
    self.curQuestion = [[Question alloc] init];
    [self.view addSubview:talkToolBar];
    [self.view addSubview:self.tableView];
    [self getWelcomeMessage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardDidHideNotification object:nil];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"begin edit...");
}

-(void)keyBoardShow:(id)sender{
    NSLog(@"keyboard show");
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"end edit...");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"return...");
    [self doSend:nil];
    [self.tfMessage resignFirstResponder];
    return YES;
}

-(void)keyBoardHide:(id)sender{
    NSLog(@"key board hide");
}

-(void)doSend:(id)sender{
    Message* message = [[Message alloc] init];
    message.time = [CommonTools getIntervalTimeString:nil];
    message.messageType = SELF_MESSAGE_TYPE;
    message.message = self.tfMessage.text;
    message.header = @"setting";
    [self refreshMessage:message];
    self.tfMessage.text = @"";
}

-(void)refreshMessage:(Message*)message{
    [self.messages addObject:message];
    [self.tableView reloadData];
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.messages count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell* cell = [MessageCell createCell:tableView];
    [cell setMessage: [self.messages objectAtIndex:indexPath.row]];
    self.rowHeight = cell.height;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.rowHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

-(void)getWelcomeMessage{
    [[BusinessManager shareManager] doRequest:@"GetQuestion" params:@{@"question_id":@0} success:^(id value) {
        if ([[value valueForKey:@"code"] integerValue] == 0) {
            self.curQuestion.questionId = [[value valueForKey:@"data"] valueForKey:@"question_id"];
            self.curQuestion.questionInfo = [[value valueForKey:@"data"] valueForKey:@"question_info"];
            NSLog(@"question_id:%@, question_info:%@", self.curQuestion.questionId, self.curQuestion.questionInfo);
            Message* message = [[Message alloc] init];
            message.messageType = MACHINE_MESSAGE_TYPE;
            message.time = [CommonTools getIntervalTimeString:nil];
            message.message = self.curQuestion.questionInfo;
            message.header = @"self";
            [self refreshMessage: message];
        }
        
    } failure:^(NSError *error) {
        //
        NSLog(@"error");
    }];
}

@end
