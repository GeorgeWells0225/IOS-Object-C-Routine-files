

#import "UIKitPrjDoubleTouch.h"

@implementation UIKitPrjDoubleTouch

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  // 允许多点触摸时必须将此属性设置成YES
  self.view.multipleTouchEnabled = YES;
}

#pragma mark ----- Responder -----

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  NSString* message = [NSString stringWithFormat:@"共有%d个手指同时触摸了屏幕", [touches count]];
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:nil
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil] autorelease];
  [alert show];
}

@end
