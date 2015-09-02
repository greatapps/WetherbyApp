//
//  NewsFeedVC.m
//  EventApp
//
//  Created by Rajeev Dubey on 02/09/15.
//  Copyright (c) 2015 GrXtreme Technologies. All rights reserved.
//

#import "Header.h"

@interface NewsFeedVC ()

@end

@implementation NewsFeedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set screen title
    [self setTitle:@"News"];
    
    // adding navigation bar buttons
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuicon"] style:UIBarButtonItemStylePlain target:self action:@selector(menuAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"alarmicon"] style:UIBarButtonItemStylePlain target:self action:@selector(alarmAction)];
}

#pragma mark- Button Action

// menu button
- (void)menuAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

// alarm button
- (void)alarmAction
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
