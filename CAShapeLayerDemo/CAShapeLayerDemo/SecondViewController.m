//
//  SecondViewController.m
//  CADisplayLinkDemo
//
//  Created by wyy on 16/11/15.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import "SecondViewController.h"
#import "MMSubView.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:70/255.0 green:136/255.0 blue:65/255.0 alpha:1];
    MMSubView *view = [[MMSubView alloc] initWithFrame:self.view.bounds];

    [self.view addSubview:view];
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
