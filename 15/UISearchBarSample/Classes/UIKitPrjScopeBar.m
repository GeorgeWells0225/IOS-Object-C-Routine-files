//
//  UIKitPrjScopeBar.m


#import "UIKitPrjScopeBar.h"

@implementation UIKitPrjScopeBar

- (void)viewDidLoad {
  [super viewDidLoad];

  UISearchBar* searchBar = [[[UISearchBar alloc] init] autorelease];
  searchBar.frame = CGRectMake( 0, 0, 320, 0 );
  searchBar.delegate = self;

  searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"AAA", @"BBB", @"CCC", nil];
  searchBar.showsScopeBar = YES;

  [searchBar sizeToFit];

  [self.view addSubview:searchBar];
}

- (void)searchBar:(UISearchBar*)searchBar
  selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
  NSLog( @"selectedScopeButtonIndexDidChange %d", selectedScope );
  NSLog( @"selectedScopeButtonIndex %d", searchBar.selectedScopeButtonIndex );
}

@end
