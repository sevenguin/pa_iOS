//
//  TalkToolBar.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/25.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "TalkToolBar.h"

@implementation TalkToolBar

+(instancetype)toolBar{
    TalkToolBar* talkTB = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    return talkTB;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
