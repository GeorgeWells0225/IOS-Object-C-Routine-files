//
//  UIToolBarAppDelegate.h


#import <UIKit/UIKit.h>

@class UIToolBarViewController;

@interface UIToolBarAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIToolBarViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIToolBarViewController *viewController;

@end

