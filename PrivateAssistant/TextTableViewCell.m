//
//  TextTableViewCell.m
//  PrivateAssistant
//
//  Created by sevenguin on 15/12/30.
//  Copyright © 2015年 weill. All rights reserved.
//

#import "TextTableViewCell.h"
@interface TextTableViewCell()
@end

@implementation TextTableViewCell

-(void)showView:(NSString*)text{
    [self.textLabel setText:text];
}

@end
