
#import "CBus_CityDataViewController.h"
#import "CDataContainer.h"

#define BaseURL @"http://192.168.5.108/~apple/Database/"


@implementation CBus_CityDataViewController

@synthesize cityDataTableView;
@synthesize progressView;
@synthesize urlArray;
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.prompt = @"选择城市名称进行数据下载:";
	
	progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
	progressView.frame = CGRectMake(100, 20, 200, 10);
	progressView.progress = 0.0;	
    NSString *path = [[NSBundle mainBundle] pathForResource:@"URLDatabase" ofType:@"plist"];
	
    if (path){
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
		[CDataContainer Instance].allCityArray = [NSMutableArray  arrayWithArray:[dict allKeys]];
		
		if (urlArray == nil) {
			urlArray = [[NSMutableArray alloc] init];
		}
		self.urlArray  = [NSMutableArray  arrayWithArray:[dict allValues]];    
		NSLog(@"urlArray-----%@",urlArray);
    }

}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	 self.title = @"城市信息下载";
	[[HttpRequest sharedRequest] setRequestDelegate:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];	
	[[HttpRequest sharedRequest] setRequestDelegate:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	 return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[CDataContainer Instance].allCityArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
    // Configure the cell...
	
	cell.textLabel.text = [[CDataContainer Instance].allCityArray objectAtIndex:indexPath.row];
	cell.imageView.image = [UIImage imageNamed:@"bus_download.png"];
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	
	self.cityDataTableView.userInteractionEnabled = NO;
	downloadCityName = [NSString stringWithString:[[CDataContainer Instance].allCityArray objectAtIndex:indexPath.row]];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *tempPath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[urlArray objectAtIndex:indexPath.row]];
	
	
	progressView.hidden = NO;
	progressView.progress = 0.0;
	[[tableView cellForRowAtIndexPath:indexPath].contentView addSubview:progressView];

	[[HttpRequest sharedRequest] sendDownloadDatabaseRequest:[urlArray objectAtIndex:indexPath.row] desPath:tempPath];
}

// 开始发送请求,通知外部程序
- (void)connectionStart:(HttpRequest *)request
{
	NSLog(@"开始发送请求,通知外部程序");
}

// 连接错误,通知外部程序
- (void)connectionFailed:(HttpRequest *)request error:(NSError *)error
{
	NSLog(@"连接错误,通知外部程序");
	
	self.cityDataTableView.userInteractionEnabled = YES;

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
													message:@"连接错误" 
												   delegate:self 
										  cancelButtonTitle:@"确定"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

// 开始下载，通知外部程序
- (void)connectionDownloadStart:(HttpRequest *)request
{
	NSLog(@"开始下载，通知外部程序");
}

// 下载结束，通知外部程序
- (void)connectionDownloadFinished:(HttpRequest *)request
{
	NSLog(@"下载结束，通知外部程序");
	
	self.progressView.hidden = YES;
	self.cityDataTableView.userInteractionEnabled = YES;
	NSUserDefaults	*userDefault = [NSUserDefaults standardUserDefaults];

	BOOL	isNotAlready = YES;
	
	for(NSString *name in [CDataContainer Instance].downloadCitysArray){
		if ([name isEqualToString:downloadCityName]) {
			isNotAlready = NO;
		}
	}
	
	if (isNotAlready) {
		[[CDataContainer Instance].downloadCitysArray addObject:downloadCityName];
		[userDefault setObject:[CDataContainer Instance].downloadCitysArray forKey:@"downloadCitys"];
		[userDefault synchronize];
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
													message:@"下载完成" 
												   delegate:self 
										  cancelButtonTitle:@"确定"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];

}

// 更新下载进度，通知外部程序
- (void)connectionDownloadUpdateProcess:(HttpRequest *)request process:(CGFloat)process
{
	NSLog(@"Process = %f", process);
	progressView.progress = process;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];

}


- (void)dealloc {
    [super dealloc];
	[cityDataTableView release];
	[progressView release];
	[urlArray release];
}
@end
