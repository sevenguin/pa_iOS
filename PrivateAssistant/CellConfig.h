//
//  CellConfig.h
//  PrivateAssistant
//
//  Created by sevenguin on 15/12/31.
//  Copyright © 2015年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextTableViewCell.h"
#import "Configure.h"

@interface CellConfig : UITableViewCell

@property (nonatomic)Class cellType;
@property (nonatomic)SEL action;
@property (nonatomic)NSObject *params;

-(instancetype)initWithCellType:(Class)cellType
                         action:(SEL)action params:(NSObject*)params
                  accessoryType:(UITableViewCellAccessoryType)accessoryType;

-(UITableViewCell*)getTableViewCell:(UITableView*)tableView;

@end
