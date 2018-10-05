//
//  UIKitPrjSimple.h


#import <UIKit/UIKit.h>

@interface UIKitPrjSimple : UIViewController <UITextFieldDelegate>
{
 @private
  NSArray* textFields_;
  NSUInteger currentFieldIndex_;
}
@end
