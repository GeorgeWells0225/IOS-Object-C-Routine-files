

#import "UIKitPrjEditingButton.h"

@implementation UIKitPrjEditingButton

- (void)viewDidLoad {
  [super viewDidLoad];
  dataSource_ = [[NSMutableArray alloc] initWithObjects:
                              @"aaa1", @"aaa2", @"aaa3",
                              nil ];
  self.navigationItem.rightBarButtonItem = [self editButtonItem];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  self.tableView.editing = NO;
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath*)indexPath {
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath*)indexPath {
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  if ( editing ) {
    // 编辑模式时追加「追加新单元」单元
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:dataSource_.count inSection:0];
    [dataSource_ addObject:@"添加新单元格"];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
  } else {
    // 结束编辑模式时，删除「追加新单元」单元
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:dataSource_.count-1 inSection:0];
    [dataSource_ removeLastObject];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
  }
  [super setEditing:editing animated:YES];
}

@end
