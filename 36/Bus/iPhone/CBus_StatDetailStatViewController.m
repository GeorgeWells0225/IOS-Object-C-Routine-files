//
//  CBus_StatDetailStatViewController.m


#import "CBus_StatDetailStatViewController.h"
#import "CBus_StationDetailViewController.h"
#import "CBus_LineDetailLineViewController.h"
#import "CDataContainer.h"

@implementation CBus_StatDetailStatViewController

@synthesize busLineDetailTableView,currentLineName;
@synthesize currentLineIndex;
@synthesize isStatToStat;

// 视图初始化
- (void)viewDidLoad{
    [super viewDidLoad];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																						   target:self
																						   action:@selector(AddLineToFavorite)];
	
	[[CDataContainer Instance] GetLineStationFromTableSequence:currentLineIndex];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.busLineDetailTableView reloadData];
    NSLog(@"-----Nav----%@",self.navigationController.viewControllers);
	
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
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
	isStatToStat = NO;
}



-(void)AddLineToFavorite{
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
	
	[[CDataContainer Instance] InsertFavoriteInfoToDatabase:0 AddName:currentLineName AddIndex:currentLineIndex AddNameEnd:nil AddIndexEnd:0];
	
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.	
    return [[CDataContainer Instance].sequenceNumArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    cell.textLabel.text = [[CDataContainer Instance].stationNameArray objectAtIndex:[[CDataContainer Instance] GetBusLineSequenceByIndex:indexPath.row]-1];
	cell.imageView.image = [UIImage imageNamed:@"bus_table_stat.png"];

	return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Navigation logic may go here. Create and push another view controller.
	if (isStatToStat) {
		return;
	}
	
    CBus_StationDetailViewController *statDetailViewController = [self.navigationController.viewControllers objectAtIndex:1];

    statDetailViewController.currentStationName = [[CDataContainer Instance].stationNameArray objectAtIndex:[[CDataContainer Instance] GetBusLineSequenceByIndex:indexPath.row]-1];
    statDetailViewController.currentStationIndex = [[CDataContainer Instance].stationNameArray indexOfObject:statDetailViewController.currentStationName]+1;
 
	[self.navigationController popViewControllerAnimated:YES];
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{

}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
// Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
	self.busLineDetailTableView = nil;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[busLineDetailTableView release];
    [super dealloc];
}


@end
