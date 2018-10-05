//
//  LeveyTabBarDemoAppDelegate.h
//  LeveyTabBarDemo
//


#import <UIKit/UIKit.h>

@class LeveyTabBarController;

@interface LeveyTabBarDemoAppDelegate : NSObject <UIApplicationDelegate, UINavigationControllerDelegate> {
    UIWindow *window;
    LeveyTabBarController *leveyTabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LeveyTabBarController *leveyTabBarController;

@end

