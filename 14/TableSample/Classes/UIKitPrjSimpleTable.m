//
//  UIKitPrjSimpleTable.m


#import "UIKitPrjSimpleTable.h"

@implementation UIKitPrjSimpleTable

- (void)dealloc {
  [dataSource_ release];//画面释放时也需释放保存元素的数组
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  //初始化表格元素数值
  dataSource_ = [[NSArray alloc] initWithObjects:
                              @"AAA1", @"AAA2", @"AAA3",
                              @"AAA", @"AAA5", @"AAA6",
                              @"AAA7", @"AAA8", @"AAA9",
                              @"AAA10", @"AAA11", @"AAA12",
                              @"AAA13", @"AAA14", @"AAA15",
                              @"AAA16", @"AAA17", @"AAA18",
                              nil ];
}
//返回表格行数（本例只有单元数）
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
  return [dataSource_ count];
}
//创建各单元显示内容（创建参数indexPath指定的单元）
- (UITableViewCell*)tableView:(UITableView*)tableView
  cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
  //为了提供表格显示性能，已创建完成的单元需重复使用
  static NSString* identifier = @"basis-cell";
  //同一形式的单元格重复使用（基本上各形式相同而内容是不同的）
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if ( nil == cell ) {
	//初始为空时必须创建
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
    [cell autorelease];
  }
  //设置单元格中的显示内容
  cell.textLabel.text = [dataSource_ objectAtIndex:indexPath.row];
  return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
  NSString* message = [dataSource_ objectAtIndex:indexPath.row];
  UIAlertView* alert = [[[UIAlertView alloc] init] autorelease];
  alert.message = message;
  [alert addButtonWithTitle:@"OK"];
  [alert show];
}

@end