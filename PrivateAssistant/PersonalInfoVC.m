//
//  PersonalInfoVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/4.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "CellConfig.h"
#import "CommonChooseVC.h"
#import "TextFieldVC.h"
#import "CacheData.h"

@interface PersonalInfoVC ()

@property (nonatomic)NSArray* cells;
@property (nonatomic)NSArray* baseCells;
@property (nonatomic)NSArray* externCells;
@property (nonatomic)NSArray* menuBaseList;
@property (nonatomic)NSArray* menuExternList;

@end

@implementation PersonalInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSBundle mainBundle] loadNibNamed:@"PersonalInfo" owner:self options:nil];
    self.tvPersonalInfo.dataSource = self;
    self.tvPersonalInfo.delegate = self;
    self.menuBaseList = [[Configure getPersonalInfoList] valueForKey:@"base"];
    self.menuExternList = [[Configure getPersonalInfoList] valueForKey:@"extern"];
    self.baseCells = [Configure batchInitFromCellType:[TextTableViewCell class] action:@selector(showView:) params:self.menuBaseList accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    self.externCells = [Configure batchInitFromCellType:[TextTableViewCell class] action:@selector(showView:) params:self.menuExternList accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    self.cells = @[self.baseCells/*, self.externCells*/];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登陆" style:UIBarButtonItemStyleDone target:self action:@selector(quit:)];
    // Do any additional setup after loading the view.
    //下拉列表里面，每一个选项增加一个增加按钮，这样不需要显示增加按钮---这个显得很笨重
}

-(void)quit:(id)sender{
    [CacheData setUsers:KEY_STATUS_LOGIN value:VALUE_STATUS_UNLOGIN];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cells[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cells.count;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @[@"基本信息"/*, @"扩展信息"*/][section];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellConfig *cell = [[self.cells objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return [cell getTableViewCell:tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIViewController *toVc = [[NSClassFromString([[Configure getCommonChooseListToVC:@"base"] valueForKey:self.menuBaseList[indexPath.row]]) alloc] init];
        if ([toVc isKindOfClass:[CommonChooseVC class]]) {
            ((CommonChooseVC*)toVc).type = self.menuBaseList[indexPath.row];
        }else if([toVc isKindOfClass:[TextFieldVC class]]){
            ((TextFieldVC*)toVc).actionStr = [[Configure getSureActionStr] valueForKey:self.menuBaseList[indexPath.row]];
        }
        [toVc.view setBackgroundColor:[UIColor whiteColor]];
        [self.navigationController pushViewController:toVc animated:YES];
    }else{
        UIViewController *toVc = [[NSClassFromString([[Configure getCommonChooseListToVC:@"extern"] valueForKey:self.menuExternList[indexPath.row]]) alloc] init];
        [toVc.view setBackgroundColor:[UIColor whiteColor]];
        [self.navigationController pushViewController:toVc animated:YES];
    }
    
}

@end
