

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>



@interface CSettingViewController : UIViewController <UITableViewDelegate,
									UITableViewDataSource, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>{

	UITableView		*settingTableView;
	
	UILabel			*cityNumLab;
	UILabel			*currentCityLab;
									
	NSInteger		cityNum;
}

@property (nonatomic, retain) IBOutlet UITableView		*settingTableView;
@property (nonatomic, retain) UILabel	*cityNumLab;
@property (nonatomic, retain) UILabel   *currentCityLab;


@end
