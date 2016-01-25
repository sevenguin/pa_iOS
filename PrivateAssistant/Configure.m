//
//  Configure.m
//  PrivateAssistant
//
//  Created by sevenguin on 15/12/30.
//  Copyright © 2015年 weill. All rights reserved.
//

#import "Configure.h"
#import "CacheData.h"

@implementation Configure

+(NSString*)getCurrentLanguage{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *curLanguage = [languages objectAtIndex: 0];
    return curLanguage;
}

+(NSArray*)getSettingMenuList{
    NSString *curLanguage = [self getCurrentLanguage];
    NSString* status = [[CacheData getUsers] valueForKey:KEY_STATUS_LOGIN];
    NSString* first = @"登陆/注册";
    if ([status  isEqual: VALUE_STATUS_LOGIN]) {
        first = [[CacheData getUsers] valueForKey:KEY_USER_NAME];
    }
    if (!first) {
        first = @"";
    }
    NSArray *cnMenu = @[first, /*@"个人信息", @"历史",*/ @"版本信息", @"反馈", @"股权", @"致用户书"];
    NSArray *enMenu = cnMenu;//@[@"login/register?", @"self info", /*@"History",*/ @"Version", @"Feedback", @"Right", @"To User"];
    if([curLanguage isEqualToString:@"zh-Hans-US"]){
        return cnMenu;
    }else{
        return enMenu;
    }
}

+(NSArray*)batchInitFromCellType:(Class)cellType action:(SEL)action params:(NSArray*)params
                   accessoryType:(UITableViewCellAccessoryType)accessoryType{
    NSMutableArray *cells = [[NSMutableArray alloc] initWithCapacity:[params count]];
    for (NSObject *param in params) {
        CellConfig *cell = [[CellConfig alloc] initWithCellType:cellType action:action params:param accessoryType:accessoryType];
        [cells addObject:cell];
    }
    return cells;
}

+(NSDictionary*)getSettingMenuToVC{
    NSArray* menuList = [self getSettingMenuList];
    NSString* status = [[CacheData getUsers] valueForKey:KEY_STATUS_LOGIN];
    NSString* first = @"LoginVC";
    if ([status  isEqual: VALUE_STATUS_LOGIN]) {
        //first = @"UserInfoVC";  先设置成个人信息
        first = @"PersonalInfoVC";
    }
    NSArray* objList = @[first, /*@"PersonalInfoVC", @"HistoryVC",*/ @"WebContainerVC", @"WebContainerVC", @"WebContainerVC", @"WebContainerVC"];
    NSMutableDictionary* settingMenuToVC = [[NSMutableDictionary alloc] initWithCapacity:[menuList count]];
    for (NSInteger i = 0; i < [menuList count]; i++) {
        [settingMenuToVC setObject:objList[i] forKey:menuList[i]];
    }
    return settingMenuToVC;
}

+(NSDictionary*)getSettingMenuHtml{
    NSArray* menuList = [self getSettingMenuList];
    NSArray* htmlList = @[@"", @"", @"Version", @"Feedback", @"Right", @"Touser"];
    NSMutableDictionary* settingMenuHtml = [[NSMutableDictionary alloc] initWithCapacity:[menuList count]];
    for (NSInteger i = 0; i < [menuList count]; i++) {
        [settingMenuHtml setObject:htmlList[i] forKey:menuList[i]];
    }
    return settingMenuHtml;
}

+(NSDictionary*)getPersonalInfoList{
    return @{@"base":@[@"用户昵称", @"曾经生活过的地方", @"饮食偏好", @"故乡", @"饮食禁忌", @"就餐时间"],
             /*@"extern":@[@"餐馆黑名单", @"餐馆偏好", @"关联社交账号"]*/};
}

+(NSDictionary*)getCommonChooseListToVC:(NSString*)type{
    NSArray* menuList = [[self getPersonalInfoList] valueForKey:type];
    NSMutableDictionary* settingMenuToVC = [[NSMutableDictionary alloc] initWithCapacity:[menuList count]];
    for (int i = 1; i < [menuList count]; i++) {
        [settingMenuToVC setObject:@"CommonChooseVC" forKey:menuList[i]];
    }
    [settingMenuToVC setObject:@"TextFieldVC" forKey:menuList[0]];
    return settingMenuToVC;
}

+(NSDictionary*)getSureActionStr{
    return @{@"用户昵称": @"nickname"};
}

+(NSDictionary*)getPersonaInfoSingleTitles{
    return @{@"曾经生活过的地方":@[@"杭州", @"成都"]
             };
}

@end
