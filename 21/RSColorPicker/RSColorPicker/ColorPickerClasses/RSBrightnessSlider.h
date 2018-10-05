
#import <Foundation/Foundation.h>

@class RSColorPickerView;

@interface RSBrightnessSlider : UISlider {
	RSColorPickerView *colorPicker;
}

-(void)setUseCustomSlider:(BOOL)use;
-(void)setupImages;

-(void)setColorPicker:(RSColorPickerView*)cp;

@end
