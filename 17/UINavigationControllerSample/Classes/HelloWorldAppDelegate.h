//
//  HelloWorldAppDelegate.h


#import <UIKit/UIKit.h>

@interface HelloWorldAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow* window_;
  UIViewController* rootController_;
}

@property (nonatomic, retain) UIWindow* window;

@end

