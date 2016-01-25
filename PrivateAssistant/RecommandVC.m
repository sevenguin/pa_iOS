//
//  RecommandVC.m
//  PrivateAssistant
//
//  Created by sevenguin on 15/12/28.
//  Copyright © 2015年 weill. All rights reserved.
//

#import "RecommandVC.h"

@interface RecommandVC ()

@end

@implementation RecommandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:@"setting.png"];
    UIButton *btnUser = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [btnUser addTarget:self action:@selector(doSetting:) forControlEvents:UIControlEventTouchDown];
    [btnUser setBackgroundImage:image forState:UIControlStateNormal];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnUser];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithWhite:0.2 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doSetting:(id)sender{
    SettingVC *setting = [[SettingVC alloc] init];
    setting.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:setting animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
