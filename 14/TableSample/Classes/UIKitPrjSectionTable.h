//
//  UIKitPrjSectionTable.h


#import <UIKit/UIKit.h>

@interface UIKitPrjSectionTable : UITableViewController
{
 @private
  NSArray* keys_;//保持段名的数组
  NSDictionary* dataSource_;//以字典形式保持的表格数据资源
}
@end
