//
//  HelloWorldAppDelegate.h


#import <UIKit/UIKit.h>

@interface HelloWorldAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window_;
  UIViewController* viewController1_;
  UIViewController* viewController2_;
}

@property (nonatomic, retain) UIWindow* window;

@end

