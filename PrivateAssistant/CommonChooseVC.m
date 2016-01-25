//
//  CommonChooseVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/5.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "CommonChooseVC.h"
#import "Configure.h"
#import "TextTableViewCell.h"
#import "SearchVC.h"
#import "BusinessManager.h"
#import "CacheData.h"

@interface CommonChooseVC ()
@property (nonatomic)NSMutableArray* cells;
@property (nonatomic)UISearchController* searchController;
@property (nonatomic)BOOL isCancel;
@property (nonatomic)NSMutableArray* titles;
@property (nonatomic)NSMutableArray* totalTitles;
@property (nonatomic)SearchVC* searchDele;
@end

@implementation CommonChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSBundle mainBundle] loadNibNamed:@"CommonChoose" owner:self options:nil];
    self.searchDele = [[SearchVC alloc] init];
    [self setViewByType];
    self.searchDele.textList = self.totalTitles;
    self.cells = [[NSMutableArray alloc] initWithArray:[Configure batchInitFromCellType:[TextTableViewCell class] action:@selector(showView:) params:self.titles accessoryType:UITableViewCellAccessoryNone]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    //self.searchController.searchBar.frame = ;
    self.searchController.searchBar.delegate = self;
    
    //self.retTableView = [[UITableView alloc] init];

    //self.retTableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400);
    self.retTableView.tableHeaderView = self.searchController.searchBar;
    self.retTableView.hidden = YES;
    self.btnClose.hidden = YES;
    self.retTableView.dataSource = self.searchDele;
    self.retTableView.delegate = self.searchDele;
    
    self.navigationItem.titleView = self.searchController.searchBar;
    self.isCancel = NO;
}

-(void)setViewByType{
    //, @"饮食偏好", @"故乡", @"饮食禁忌", @"就餐时间"
    if (!_totalTitles) {
        _totalTitles = [[NSMutableArray alloc] init];
        _titles = [[NSMutableArray alloc] init];
    }
    NSString *citiesPath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    if ([self.type  isEqual: @"曾经生活过的地方"]) {
        NSDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:citiesPath];
        for (NSDictionary* cities in [tmpDict allValues]) {
            [self.totalTitles addObjectsFromArray:[cities allKeys]];
        }
        [[BusinessManager shareManager] doRequest:@"QueryUserBaseInfo" params:@{@"userid":[[CacheData getUsers] valueForKey:@"userid"]} success:^(NSDictionary* value) {
            self.titles = [value valueForKey:@"data"];
        } failure:^(NSError *error) {
            //
        }];
    }
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString* searchText = [searchController.searchBar text];
    if ([searchText isEqualToString:@""]) {
        if (self.isCancel) {
            self.isCancel = NO;
        }else{
            self.retTableView.hidden = NO;
            self.btnClose.hidden = NO;
        }
        
    }else{
        NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
        self.searchDele.textList = [self.totalTitles filteredArrayUsingPredicate:preicate];
        [self.retTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)done:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cells.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellConfig *cell = [self.cells objectAtIndex:indexPath.row];
    return [cell getTableViewCell:tableView];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //do delete
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.retTableView.hidden = YES;
    self.btnClose.hidden = YES;
    self.isCancel = YES;
    //需要把结果清除掉，否则再次hidden设置为显示，上一次结果还在
}

- (IBAction)doClose:(id)sender {
    NSMutableArray* addList = [[NSMutableArray alloc] init];
    [self searchBarCancelButtonClicked:self.searchController.searchBar];
    NSInteger rowsNum = [self.retTableView numberOfRowsInSection:0];
    for (NSInteger i = 0; i < rowsNum; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell = [self.retTableView cellForRowAtIndexPath:path];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            NSLog(@"text: %@", cell.textLabel.text);
            //或者用id？
            [addList addObject:cell.textLabel.text];
        }
    }
    //这里需要保存到后台
    //更新当前列表数据
    for (NSString* record in addList) {
        CellConfig* cell = [[CellConfig alloc] initWithCellType:[TextTableViewCell class] action:@selector(showView:) params:record accessoryType:UITableViewCellAccessoryNone];
        [self.cells addObject:cell];
        [self.tableView reloadData];
    }
    self.isCancel = NO;
    self.searchController.searchBar.showsCancelButton = NO;
    [self.searchController.searchBar resignFirstResponder];
    [self.searchController.searchBar endEditing:YES];
    self.searchController.searchBar.text = @"";
    self.retTableView.hidden = YES;
    self.btnClose.hidden = YES;
}

@end
