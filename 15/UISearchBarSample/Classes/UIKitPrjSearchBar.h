//
//  UIKitPrjSearchBar.h


#import <UIKit/UIKit.h>

@interface UIKitPrjSearchBar : UITableViewController <UISearchBarDelegate>
{
 @protected
  UISearchBar* searchBar_;
  NSMutableArray* dataBase_;
  NSMutableArray* dataSource_;
}
@end
