

#import <UIKit/UIKit.h>


@interface CBus_LineViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate, UISearchBarDelegate>{

	UITableView		*busLineTableView;
	NSMutableArray	*filteredListContent;

}

@property(nonatomic, retain) IBOutlet UITableView	 *busLineTableView;
@property(nonatomic, retain)		  NSMutableArray *filteredListContent;

@end
