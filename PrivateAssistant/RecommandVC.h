//
//  RecommandVC.h
//  PrivateAssistant
//
//  Created by sevenguin on 15/12/28.
//  Copyright © 2015年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RACSignal.h>

@interface RecommandVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
