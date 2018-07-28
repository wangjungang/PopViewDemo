//
//  ViewController.m
//  YTPopViewDemo
//
//  Created by 杨通 on 2018/7/27.
//  Copyright © 2018年 TonyAng. All rights reserved.
//

#import "ViewController.h"
#import "YTPopView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"YTPopViewDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(BtnAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 60, 60);
    [self.view addSubview:btn];
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor colorWithRed:arc4random() % 256 /255.0 green:arc4random() % 256 /255.0 blue:arc4random() % 256 /255.0 alpha:1.0];
}

- (void)BtnAction {
    YTPopView *alertView = [YTPopView new];
    alertView.sharePictureImageUrlStr = @"https://img4.duitang.com/uploads/item/201512/15/20151215200047_tkjR4.thumb.700_0.jpeg";
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
