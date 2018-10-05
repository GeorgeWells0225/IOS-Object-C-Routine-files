

#import <UIKit/UIKit.h>

enum ERunType{
	EUpLineType,
	EDownLineType,
	ENoneLineType
};

@interface CBus_LineDetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{

	UITableView		*busLineDetailTableView;
	
	//当前查询的线路的index
	NSInteger		currentLineIndex;
	NSString		*currentLineName;
	
	NSInteger		runType;
	NSMutableArray	*upLineArray;
	NSMutableArray	*downLineArray;
	
}
@property(nonatomic, retain) IBOutlet 	UITableView		*busLineDetailTableView;
@property(nonatomic, retain)	NSString		*currentLineName;
@property(nonatomic)			NSInteger		currentLineIndex;

-(void)AddLineToFavorite;



@end
