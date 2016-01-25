//
//  BaseTableViewCell.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/2.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

-(instancetype)initWithAccessoryType:(UITableViewCellAccessoryType)accessoryType{
    self = [super init];
    self.accessoryType = accessoryType;
    return self;
}

-(instancetype)init{
    self = [super init];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return self;
}

-(void)showView:(NSObject *)text{
    ;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
