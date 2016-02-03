//
//  MessageCell.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/25.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UIButton *mMessage;
@property (weak, nonatomic) IBOutlet UIButton *selfMessage;
@property (weak, nonatomic) IBOutlet UIImageView *selfHeader;
@property (weak, nonatomic) IBOutlet UIImageView *mHeader;

+(instancetype)createCell:(UITableView *)tableView;
@property (nonatomic)CGFloat height;
-(void)setMessage:(Message*)message;

@end
