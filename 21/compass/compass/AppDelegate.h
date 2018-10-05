

#import <UIKit/UIKit.h>


@class CompassView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, weak) IBOutlet CompassView *compass;

@end
