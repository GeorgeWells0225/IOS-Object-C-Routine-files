//
//  UIKitPrjUIImage.h


#import <UIKit/UIKit.h>
//UIView的子类
@interface DrawImageTest : UIView
{
 @private
  UIImage* image_;
}

- (id)initWithImage:(UIImage*)image;

@end
//画面
@interface UIKitPrjUIImage : UIViewController
@end
