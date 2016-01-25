//
//  SearchTVDelegete.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/7.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "SearchVC.h"
#import "TextTableViewCell.h"

@implementation SearchVC


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.textList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextTableViewCell* cell = [[TextTableViewCell alloc] initWithAccessoryType:UITableViewCellAccessoryNone];
    [cell showView:self.textList[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

@end
