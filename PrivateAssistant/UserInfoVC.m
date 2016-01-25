//
//  UserInfoVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/20.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "UserInfoVC.h"
#import "Configure.h"

@interface UserInfoVC ()

@property (nonatomic)NSArray* cells;
@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.cells = [Configure batchInitFromCellType:[TextTableViewCell class] action:@selector(showView:) params:@[@"基本信息", @"扩展信息"] accessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cells count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellConfig *cell = [self.cells objectAtIndex:indexPath.row];
    return [cell getTableViewCell:tableView];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"个人信息";
}

@end
