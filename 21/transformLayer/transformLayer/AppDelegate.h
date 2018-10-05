

#import <UIKit/UIKit.h>
@class CompassView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    CompassView *compass;
   
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) IBOutlet CompassView *compass;

@end
