//
//  CommonChooseVC.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/5.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonChooseVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic)NSString* type;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)NSString* searchBarPlaceHolder;
@property (weak, nonatomic) IBOutlet UITableView *retTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@end
