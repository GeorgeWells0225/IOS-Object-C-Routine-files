//
//  MailDemoAppDelegate.h
//  MailDemo
//
//  Created by 阿萨德 的 on 11-8-19.
//  Copyright 2011年 阿萨德是. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MailDemoViewController;

@interface MailDemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MailDemoViewController *viewController;

@end
