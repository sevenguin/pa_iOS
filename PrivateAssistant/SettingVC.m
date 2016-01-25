//
//  SettingVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 15/12/29.
//  Copyright © 2015年 weill. All rights reserved.
//

#import "SettingVC.h"
#import "CellConfig.h"
#import "TextTableViewCell.h"
#import "WebContainerVC.h"

@interface SettingVC ()
@property (nonatomic)NSArray* cells;
@property (nonatomic)NSArray* menuList;
@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 150) style:UITableViewStyleGrouped];
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.menuList = [Configure getSettingMenuList];
    self.cells = [Configure batchInitFromCellType:[TextTableViewCell class] action:@selector(showView:) params:self.menuList accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    NSLog(@"yes: language: %@", [Configure getCurrentLanguage]);
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *toVc = [[NSClassFromString([[Configure getSettingMenuToVC] valueForKey:self.menuList[indexPath.row]]) alloc] init];
    CellConfig *cell = [self.cells objectAtIndex:indexPath.row];
    if ([toVc isKindOfClass:[WebContainerVC class]]) {
        ((WebContainerVC*)toVc).menu = (NSString*)cell.params;
    }
    [toVc.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:toVc animated:YES];
}

@end
