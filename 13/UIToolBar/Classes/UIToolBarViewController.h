//
//  UIToolBarViewController.h



#import <UIKit/UIKit.h>

@interface UIToolBarViewController : UIViewController {
	IBOutlet UIToolbar *ToolBar;
	IBOutlet UIBarButtonItem *ToolBarBtn;
	BOOL isClick;
}
-(IBAction)ToolBarBtnAction;
@end

