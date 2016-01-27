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
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import <RACSignal.h>

@interface RecommandVC ()
@property (nonatomic)NSMutableArray* messages;
@property (nonatomic)UITextField* tfMessage;
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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:talkToolBar];
    [self.view addSubview:self.tableView];
}

-(void)doSend:(id)sender{
    [self.messages addObject:self.tfMessage.text];
    self.tfMessage.text = @"";
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
    Message* message = [[Message alloc] init];
    message.time = @"10:30";
    message.messageType = MACHINE_MESSAGE_TYPE;
    message.header = @"setting";
    message.message = [self.messages objectAtIndex:indexPath.row];
    [cell setMessage: message];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
