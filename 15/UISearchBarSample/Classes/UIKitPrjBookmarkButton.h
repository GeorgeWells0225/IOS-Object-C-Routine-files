//
//  UIKitPrjBookmarkButton.h


#import <UIKit/UIKit.h>
#import "UIKitPrjSearchBar.h"

@interface UIKitPrjBookmarkButton : UIKitPrjSearchBar
- (void)setCurrentText:(NSString*)text;
@end

@interface BookmarkDialog : UITableViewController
{
 @private
  NSArray* dataSource_;
  id parent_; //< weak
}
- (id)initWithParent:(UIViewController*)parent;
@end

