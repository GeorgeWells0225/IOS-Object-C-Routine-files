
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class RSColorPickerView;

@interface BGRSLoupeLayer : CALayer{
   CGPoint loupeCenter;
   RSColorPickerView* colorPicker;
}
@property (nonatomic) CGPoint loupeCenter;
@property (nonatomic,assign) RSColorPickerView* colorPicker;

#pragma mark - Drawing
- (void)drawGridInContext:(CGContextRef)ctx;

#pragma mark - Animation
- (void)appearInColorPicker:(RSColorPickerView*)aColorPicker;
- (void)disapear;

@end
