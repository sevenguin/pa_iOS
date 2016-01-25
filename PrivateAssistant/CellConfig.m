//
//  CellConfig.m
//  PrivateAssistant
//
//  Created by sevenguin on 15/12/31.
//  Copyright © 2015年 weill. All rights reserved.
//

#import "CellConfig.h"

@interface CellConfig()

@end

@implementation CellConfig

-(instancetype)initWithCellType:(Class)cellType
                         action:(SEL)action params:(NSObject*)params
                         accessoryType:(UITableViewCellAccessoryType)accessoryType{
    self = [super init];
    self.cellType = cellType;
    self.action = action;
    self.params = params;
    self.accessoryType = accessoryType;
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(UITableViewCell*)getTableViewCell:(UITableView*)tableView{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.cellType)];
    if (!cell) {
        cell = [[self.cellType alloc] initWithAccessoryType:self.accessoryType];
    }
    if (self.action) {
        [cell performSelector:self.action withObject:self.params];
    }
    return cell;
}

@end
