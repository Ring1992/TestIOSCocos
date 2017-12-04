//
//  NSObject+Jumping.h
//  TestIOSCocos
//
//  Created by Ring on 2017/10/17.
//  Copyright © 2017年 Ring. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "RootViewController.h"

@class Jumping;

@interface Jumping : NSObject

@property (strong, nonatomic) UIWindow *originWindow;
@property (strong, nonatomic) UIWindow *cocosWindow;

+(Jumping*)sharedInstance;
+(void)startGame;
+(void)exitGame:(NSDictionary *)dict;

@end
