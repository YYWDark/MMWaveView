//
//  ViewController.m
//  CAShapeLayerDemo
//
//  Created by wyy on 16/11/15.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import "ViewController.h"
#import "MMWaveView.h"
#import "SecondViewController.h"

@interface ViewController () <MMWaveViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MMWaveView *view = [[MMWaveView alloc] initWithFrame:self.view.bounds];
    view.delegate = self;
    [self.view addSubview:view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MMWaveViewDelegate
- (void)waveViewTriggerAction:(MMWaveView *)waveView{
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"respond to event action");
}

@end
