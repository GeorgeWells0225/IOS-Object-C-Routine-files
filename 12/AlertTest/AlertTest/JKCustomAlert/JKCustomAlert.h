

#import <UIKit/UIKit.h>
@protocol JKCustomAlertDelegate <NSObject>
@optional
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface JKCustomAlert : UIAlertView {
    id  JKdelegate;
	UIImage *backgroundImage;
    UIImage *contentImage;
    NSMutableArray *_buttonArrays;

}

@property(readwrite, retain) UIImage *backgroundImage;
@property(readwrite, retain) UIImage *contentImage;
@property(nonatomic, assign) id JKdelegate;
- (id)initWithImage:(UIImage *)image contentImage:(UIImage *)content;
-(void) addButtonWithUIButton:(UIButton *) btn;
@end
