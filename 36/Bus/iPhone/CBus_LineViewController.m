

#import "CBus_LineViewController.h"
#import "CBus_LineDetailViewController.h"
#import "CDataContainer.h"

@implementation CBus_LineViewController

@synthesize busLineTableView,filteredListContent;

// 通过viewdidload的额外设置后加载视图
- (void)viewDidLoad {
    [super viewDidLoad];

	self.filteredListContent = [NSMutableArray arrayWithCapacity:[[CDataContainer Instance].lineNameArray count]];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.busLineTableView reloadData];

	NSLog(@"-----Nav------%@",self.navigationController.viewControllers);
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	NSInteger styleNum = [userDefault integerForKey:@"styleType"];
	
	switch (styleNum) {
		case 0:{
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
			self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
			self.searchDisplayController.searchBar.barStyle = UIBarStyleDefault;
			break;
		}
		case 1:{
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
			self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
			self.searchDisplayController.searchBar.barStyle = UIBarStyleBlackOpaque;
			break;
		}
	}
	
	[self.busLineTableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
[super viewDidAppear:animated];
}
#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"公交线路";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 返回行数.
	if(tableView == self.searchDisplayController.searchResultsTableView){
		return [filteredListContent count];
	}
	else {
		return [[CDataContainer Instance].lineNameArray count];
	}
}

// 自定义表格单元的外观
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;

    // 配置单元…

	if (tableView == self.searchDisplayController.searchResultsTableView){
		[[CDataContainer Instance] GetLineStationFromTableSequence:
		 [[CDataContainer Instance].lineNameArray indexOfObject:[filteredListContent objectAtIndex:indexPath.row]]];
		
		NSString *beginStr = [[CDataContainer Instance].stationNameArray objectAtIndex:
							  [[CDataContainer Instance] GetBusLineSequenceByIndex:0]-1];
		NSString *endStr = [[CDataContainer Instance].stationNameArray objectAtIndex:
							[[CDataContainer Instance] GetBusLineSequenceByIndex:[[CDataContainer Instance].sequenceNumArray count]-1]-1];
		
		NSString *detailStr = [[NSString alloc] initWithFormat:@"%@-->%@",beginStr,endStr];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
		cell.detailTextLabel.text = detailStr;
		[detailStr release];
		
		cell.textLabel.text = [filteredListContent objectAtIndex:indexPath.row];
	}
	else{
		[[CDataContainer Instance] GetLineStationFromTableSequence:indexPath.row];

		NSString *beginStr = [[CDataContainer Instance].stationNameArray objectAtIndex:
							  [[CDataContainer Instance] GetBusLineSequenceByIndex:0]-1];
		
		NSString *endStr = [[CDataContainer Instance].stationNameArray objectAtIndex:
							[[CDataContainer Instance] GetBusLineSequenceByIndex:[[CDataContainer Instance].sequenceNumArray count]-1]-1];
		
		NSString *detailStr = [[NSString alloc] initWithFormat:@"%@-->%@",beginStr,endStr];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
		cell.detailTextLabel.text = detailStr;
		[detailStr release];
		
		cell.textLabel.text = [[CDataContainer Instance].lineNameArray objectAtIndex:indexPath.row];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.imageView.image = [UIImage imageNamed:@"bus_table_line.png"];

    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 创造和推动另一个视图控制器.
	
	CBus_LineDetailViewController *detailViewController = [[CBus_LineDetailViewController alloc] initWithNibName:@"CBus_LineDetailView" bundle:nil];
	// 选定的对象到新视图控制器
	if (tableView == self.searchDisplayController.searchResultsTableView){		
		detailViewController.currentLineName = [filteredListContent objectAtIndex:indexPath.row];
		detailViewController.currentLineIndex = [[CDataContainer Instance].lineNameArray indexOfObject:[filteredListContent objectAtIndex:indexPath.row]];
	}
	else{
		detailViewController.currentLineName = [[CDataContainer Instance].lineNameArray objectAtIndex:indexPath.row];
		detailViewController.currentLineIndex = indexPath.row;
	}

	[self.navigationController pushViewController:detailViewController animated:YES];

	[detailViewController release];
	 
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
	/*
	 基于搜索文本和范围更新过滤阵列.
	 */
	// 清除过滤数组.
	[self.filteredListContent removeAllObjects]; 
	
	/*
	 主要的搜索列表类型相匹配的范围（如果选择），其名字比赛要查找的文字；添加项目匹配的滤波阵列
	 */

	for (int i = 0; i < [[CDataContainer Instance].lineNameArray count]; i++){
		NSString * searchInfo = [[CDataContainer Instance].lineNameArray objectAtIndex:i];
		
		NSComparisonResult result = [searchInfo compare:searchText 
												options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)
												  range:NSMakeRange(0, [searchText length])];
		
		if (result == NSOrderedSame){
			[self.filteredListContent addObject:searchInfo];
		}
	}
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // 重新加载返回的搜索结果
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

/**/
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
    self.busLineTableView = nil;
	
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[busLineTableView release];
	[filteredListContent release];
    [super dealloc];
}


@end
