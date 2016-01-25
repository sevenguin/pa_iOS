//
//  BaseTableViewCell.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/2.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

-(instancetype)init;
-(instancetype)initWithAccessoryType:(UITableViewCellAccessoryType)accessoryType;
-(void)showView:(NSObject*)text;

@end
