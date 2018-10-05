
#import "UIKitPrjTripleTap.h"

@implementation UIKitPrjTripleTap

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  singleTapReady_ = NO;
  doubleTapReady_ = NO;
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
  NSInteger tapCount = [[touches anyObject] tapCount];
  if ( 2 > tapCount ) {
    singleTapReady_ = YES;
    [self performSelector:@selector(singleTap)
               withObject:nil
               afterDelay:0.3f];
  } else if ( 3 > tapCount ) {
    doubleTapReady_ = YES;
    [self performSelector:@selector(doubleTap)
               withObject:nil
               afterDelay:0.3f];
  } else {
    [self performSelector:@selector(tripleTap)];
  }

}

- (void)singleTap {
  if ( !singleTapReady_ ) return;
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:nil
                                                   message:@"这是一次触摸!"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil] autorelease];
  [alert show];
}

- (void)doubleTap {
  if ( !doubleTapReady_ ) return;
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:nil
                                                   message:@"这是两次触摸!!"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil] autorelease];
  [alert show];
}

- (void)tripleTap {
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:nil
                                                   message:@"这是三次触摸!!!"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil] autorelease];
  [alert show];
}

@end
