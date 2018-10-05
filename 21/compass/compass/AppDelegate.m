
#import "AppDelegate.h"
#import "CompassLayer.h"
#import "CompassView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppDelegate
@synthesize compass;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
 
    CompassView *view=[[CompassView alloc]initWithFrame:CGRectMake(40, 83, 240, 240)];
    //view.backgroundColor=[UIColor blueColor];

    [self.window addSubview:view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
