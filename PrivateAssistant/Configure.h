//
//  Configure.h
//  PrivateAssistant
//
//  Created by sevenguin on 15/12/30.
//  Copyright © 2015年 weill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellConfig.h"

@interface Configure : NSObject

+(NSString*)getCurrentLanguage;
+(NSArray*)getSettingMenuList;
+(NSDictionary*)getSettingMenuToVC;
+(NSDictionary*)getSettingMenuHtml;
+(NSArray*)batchInitFromCellType:(Class)cellType action:(SEL)action params:(NSArray*)params
                   accessoryType:(UITableViewCellAccessoryType)accessoryType;
+(NSDictionary*)getPersonalInfoList;
+(NSDictionary*)getCommonChooseListToVC:(NSString*)type;
+(NSDictionary*)getPersonaInfoSingleTitles;
+(NSDictionary*)getSureActionStr;

@end
