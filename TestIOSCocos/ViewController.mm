//
//  ViewController.m
//  TestIOSCocos
//
//  Created by Ring on 2017/10/12.
//  Copyright © 2017年 Ring. All rights reserved.
//

#import "ViewController.h"
#import "Jumping.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotate {
    return NO;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (IBAction)clickStartGame:(UIButton *)sender {
    NSLog(@"Start Game!");
    [Jumping startGame];
}

@end
