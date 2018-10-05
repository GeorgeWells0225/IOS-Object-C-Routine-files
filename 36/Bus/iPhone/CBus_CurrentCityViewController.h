

#import <UIKit/UIKit.h>


@interface CBus_CurrentCityViewController : UITableViewController {

	
	NSIndexPath	*lastIndexPath;
	
	NSString	*selectCityName;
}

@property (nonatomic, retain) NSIndexPath *lastIndexPath;
@property (nonatomic, retain) NSString *selectCityName;

@end
