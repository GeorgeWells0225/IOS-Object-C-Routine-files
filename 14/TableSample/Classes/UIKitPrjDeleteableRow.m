//
//  UIKitPrjDeleteableRow.m


#import "UIKitPrjDeleteableRow.h"

@implementation UIKitPrjDeleteableRow

- (void)dealloc {
  [dataSource_ release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  dataSource_ = [[NSMutableArray alloc] initWithObjects:
                                @"AAA1", @"AAA2", @"AAA3",
                                @"AAA", @"AAA5", @"AAA6",
                                @"AAA7", @"AAA8", @"AAA9",
                                @"AAA10", @"AAA11", @"AAA12",
                                @"AAA13", @"AAA14", @"AAA15",
                                @"AAA16", @"AAA17", @"AAA18",
                                nil ];

}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self.tableView setEditing:YES animated:YES];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
  return [dataSource_ count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
  cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
  static NSString* identifier = @"basis-cell";
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if ( nil == cell ) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
    [cell autorelease];
  }
  cell.textLabel.text = [dataSource_ objectAtIndex:indexPath.row];
  return cell;
}

// 单元的追加/删除
- (void)tableView:(UITableView*)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
   forRowAtIndexPath:(NSIndexPath*)indexPath
{
  if ( UITableViewCellEditingStyleDelete == editingStyle ) {
    // 从datasource删除实际数据
    [dataSource_ removeObjectAtIndex:indexPath.row];
    // 删除表格中的单元
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationLeft];
  } 
}


@end
