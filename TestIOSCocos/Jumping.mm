//
//  NSObject+Jumping.m
//  TestIOSCocos
//
//  Created by Ring on 2017/10/17.
//  Copyright © 2017年 Ring. All rights reserved.
//

#import "Jumping.h"
static Jumping *_sharedInstance = nil;

@implementation Jumping

+(Jumping*)sharedInstance{
    if (!_sharedInstance) {
        _sharedInstance =[[self alloc]init];
    }
    return _sharedInstance;
}

+(void)startGame{
    
    Jumping *jumping = [Jumping sharedInstance];
    jumping.originWindow = [[[UIApplication sharedApplication] delegate] window];
    CGRect frame = [UIScreen mainScreen].bounds;
    
    UIWindow* tmpWindow = [[UIWindow alloc] initWithFrame:frame];
    jumping.cocosWindow = tmpWindow;
    tmpWindow.backgroundColor = [UIColor clearColor];
    tmpWindow.windowLevel = UIWindowLevelNormal;
    
    RootViewController *rootVC = [[RootViewController alloc] init];
    tmpWindow.rootViewController = rootVC;
    rootVC.view.frame = tmpWindow.bounds;
    rootVC.view.backgroundColor = [UIColor clearColor];
    [tmpWindow makeKeyAndVisible];
}

+(void)exitGame:(NSDictionary *)dict{
    NSLog(@"Exit Game!");
    cocos2d::Director::getInstance()->end();
    Jumping *jumping = [Jumping sharedInstance];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:jumping selector:@selector(delayMethod) userInfo:nil repeats:NO];
}

- (void)delayMethod{
    NSLog(@"delayMethodEnd");
    Jumping *jumping = [Jumping sharedInstance];
    [jumping.cocosWindow resignKeyWindow];
    [jumping.originWindow makeKeyAndVisible];
    jumping.cocosWindow = nil;
}

@end
