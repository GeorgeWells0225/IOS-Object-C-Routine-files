

#import <UIKit/UIKit.h>
#import "RSColorPickerView.h"
#import "RSBrightnessSlider.h"

@interface RSColorPickerAppDelegate : NSObject <UIApplicationDelegate, RSColorPickerViewDelegate> {
	RSColorPickerView *colorPicker;
	RSBrightnessSlider *brightnessSlider;
	UIView *colorPatch;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
