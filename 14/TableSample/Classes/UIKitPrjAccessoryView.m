//
//  UIKitPrjAccessoryView.m
//
//  Created by wang on 2011-10-18.
//

#import "UIKitPrjAccessoryView.h"

@implementation UIKitPrjAccessoryView

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = nil;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
  cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
  //如果父类中没有追加创建UITableViewCell实例代码时，需要在此追加相关代码
  UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
  UIButton* button = [UIButton buttonWithType:UIButtonTypeInfoDark];
  [button addTarget:self
             action:@selector(infoDidPush)
   forControlEvents:UIControlEventTouchUpInside];

  cell.accessoryView = button;
  return cell;
}

- (void)infoDidPush {
  //ModalViewController为另创建的画面
  //UIViewController* viewController = [[ModalViewController alloc] init];
  //[self presentModalViewController:viewController animated:YES];
  //[viewController release];
}

@end
