//
//  MessageCell.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/25.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "MessageCell.h"
#import <MASConstraintMaker.h>
#import "Masonry.h"

@interface MessageCell()

@property (nonatomic) UILabel *lbTime;
@property (nonatomic) UIImageView *mHeader;
@property (nonatomic) UIButton *mMessage;
@property (nonatomic) UIButton *selfMessage;
@property (nonatomic) UIImageView *selfHeader;
@property (nonatomic)CGFloat height;

@end

@implementation MessageCell

+(instancetype)createCell:(UITableView *)tableView{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messagecell"];
    if(!cell){
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
        cell.lbTime = cell.subviews[0].subviews[1];
        cell.mHeader = cell.subviews[0].subviews[2];
        cell.selfHeader = cell.subviews[0].subviews[3];
        cell.mMessage = cell.subviews[0].subviews[4];
        cell.selfMessage = cell.subviews[0].subviews[5];
    }
    return cell;
}

-(void)setMessage:(Message*)message{
    self.lbTime.text = message.time;
    if(message.messageType == MACHINE_MESSAGE_TYPE){
        self.selfHeader.hidden = YES;
        self.selfMessage.hidden = YES;
        self.mHeader.hidden = NO;
        self.mMessage.hidden = NO;
        [self.mMessage setTitle:message.message forState:UIControlStateNormal];
        [self showMessage:self.mMessage header:self.mHeader];
    }else{
        self.selfHeader.hidden = NO;
        self.selfMessage.hidden = NO;
        self.mHeader.hidden = YES;
        self.mMessage.hidden = YES;
        [self.mMessage setTitle:message.message forState:UIControlStateNormal];
        [self showMessage:self.selfMessage header:self.selfHeader];
    }
}

-(void)showMessage:(UIButton*)button header:(UIImageView*)image{
    button.titleLabel.numberOfLines = 0;
    button.contentEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [self layoutIfNeeded];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(button.mas_height).height.offset(10);
//    }];
    //[button updateConstraints];
    self.height = CGRectGetMaxY(button.frame) > CGRectGetMaxY(image.frame) ? CGRectGetMaxY(button.frame) : CGRectGetMaxY(image.frame);
    self.height += 10;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
