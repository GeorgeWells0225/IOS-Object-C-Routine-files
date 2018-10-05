//
//  UIKitPrjBlendMode.h


#import <UIKit/UIKit.h>

@interface BlendModeTest : UIView
{
 @private
  UIImage* frontImage_;
  UIImage* backImage_;
  CGBlendMode blendMode_;
}

@property (nonatomic, assign) CGBlendMode blendMode;

- (void)changeMode;

@end

@interface UIKitPrjBlendMode : UIViewController
{
 @private
  BlendModeTest* test_;
  UILabel* label_;
}
@end
