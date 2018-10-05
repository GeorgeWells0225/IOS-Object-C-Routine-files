

#import <UIKit/UIKit.h>


#define kBeginStationComponent 0
#define kEndStationComponent 1

enum EStationType{
	EBeginStationType,
	EEndStationType,
	ENoneStationType
};

@interface CBus_StatToStatViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,
					UISearchDisplayDelegate, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{

	UITableView		*busStatToStatTableView;
	
	UISearchBar		*currentSearchBar;
	UISearchBar		*beginSearchBar;
	UISearchBar		*endSearchBar;
	
	UIPickerView	*stationPickView;
	NSInteger		 currentBeginIndex;
	NSInteger		 currentEndIndex;
	
	NSInteger		 stationType;
	
	NSMutableArray	*beginFilteredListContent;
	NSMutableArray	*endFilteredListContent;

	NSString		*ifSelectedPickerString;
	NSString		*ifSelectedPickEndString;
						
	BOOL			 isSearchBegin;
	BOOL			 isSearchEndBegin;
	BOOL			 isJumpToStat;

	UIBarButtonItem	*returnKeyBordBtn;
}
@property (nonatomic, retain) IBOutlet UITableView		*busStatToStatTableView;
@property (nonatomic, retain) IBOutlet UISearchBar		*beginSearchBar;
@property (nonatomic, retain) IBOutlet UISearchBar		*endSearchBar;
@property (nonatomic, retain) IBOutlet UIPickerView		*stationPickView;

@property(nonatomic, retain)			NSMutableArray	*beginFilteredListContent;
@property(nonatomic, retain)			NSMutableArray	*endFilteredListContent;

@property(nonatomic)  BOOL	  isJumpToStat;

- (void)filterContentForSearchText:(NSString*)searchText;

@end
