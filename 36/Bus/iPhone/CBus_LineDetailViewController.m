
#import "CBus_LineDetailViewController.h"
#import "CBus_StationDetailViewController.h"
#import "CBus_LineDetailLineViewController.h"
#import "CDataContainer.h"

@implementation CBus_LineDetailViewController

@synthesize busLineDetailTableView,currentLineName;
@synthesize currentLineIndex;




// 载入界面
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																						   target:self
																						   action:@selector(AddLineToFavorite)];
	
	[[CDataContainer Instance] GetLineStationFromTableSequence:currentLineIndex];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.busLineDetailTableView reloadData];
	
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
	
	[[CDataContainer Instance] GetLineStationFromTableSequence:currentLineIndex];
    [self.busLineDetailTableView reloadData];
	
	NSLog(@"-----Nav----%@",self.navigationController.viewControllers);
 }
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
-(void)AddLineToFavorite
{
	NSLog(@"-------addLineToFavorite---------%@---%d",currentLineName,currentLineIndex);
	
	for(NSString *lineName in [CDataContainer Instance].favoriteLineNameArray){
		if ([lineName isEqualToString:currentLineName]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏"
															message:[NSString stringWithFormat:@"%@ 已收藏",currentLineName]
														   delegate:self
												  cancelButtonTitle:@"确定"
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
			
			return;
		}
	}
	
	[[CDataContainer Instance] InsertFavoriteInfoToDatabase:0 
													AddName:currentLineName 
												   AddIndex:currentLineIndex
												 AddNameEnd:nil
												AddIndexEnd:0];

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏"
													message:[NSString stringWithFormat:@"收藏 %@ 成功",currentLineName]
												   delegate:self
										  cancelButtonTitle:@"确定"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return currentLineName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 返回行数.
    return [[CDataContainer Instance].sequenceNumArray count];
}


//自定义表格单元的外观视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    // 配置单元
    cell.textLabel.text = [[CDataContainer Instance].stationNameArray objectAtIndex:[[CDataContainer Instance] GetBusLineSequenceByIndex:indexPath.row]-1];
	cell.imageView.image = [UIImage imageNamed:@"bus_table_stat.png"];

	return cell;
}
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创造和推动另一个视图控制器.
    
	CBus_LineDetailLineViewController *detailViewController = [[CBus_LineDetailLineViewController alloc] initWithNibName:@"CBus_LineDetailLineView" bundle:nil];
	
	detailViewController.currentStationName = [[CDataContainer Instance].stationNameArray objectAtIndex:[[CDataContainer Instance] GetBusLineSequenceByIndex:indexPath.row]-1];
	detailViewController.currentStationIndex = [[CDataContainer Instance].stationNameArray indexOfObject:detailViewController.currentStationName]+1;

	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
	
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{

}


// 显示默认线路的肖像图片.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    //如果没有视图则释放它.
    [super didReceiveMemoryWarning];
    
	self.busLineDetailTableView = nil;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // .释放任何保留的主视图
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[busLineDetailTableView release];
    [super dealloc];
}


@end
