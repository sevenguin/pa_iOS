//
//  TextTableViewCell.h
//  PrivateAssistant
//
//  Created by sevenguin on 15/12/30.
//  Copyright © 2015年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

//typedef enum: NSInteger{
//    CellActionTypePushNewViewController
//}CellActionType;

@interface TextTableViewCell : BaseTableViewCell

-(void)showView:(NSString*)text;

@end
