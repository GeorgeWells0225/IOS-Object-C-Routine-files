

#import "CBus_MapViewController.h"
#import "CBus_WebMapViewController.h"
#import "CDataContainer.h"

@implementation CBus_MapViewController
@synthesize cityMapView,mapStyleSegCtr,mapNavigationBar;
@synthesize webMapViewController;

- (void)dealloc{
    [super dealloc];
	[cityMapView release];
	[mapStyleSegCtr release];
	[mapNavigationBar release];
	[webMapViewController release];
}

- (void)didReceiveMemoryWarning{
    // 释放视图
    [super didReceiveMemoryWarning];

}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
	
	UIBarButtonItem *webMapButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"WebMap"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(goToWebMap:)];
	
    self.navigationItem.rightBarButtonItem = webMapButton;
    [webMapButton release];
	
	CLLocationManager *locationMananger = [[CLLocationManager alloc] init];
	
	locationMananger.delegate = self;
	locationMananger.desiredAccuracy = kCLLocationAccuracyBest;
	locationMananger.distanceFilter = 1000.0;
	[locationMananger startUpdatingHeading];
	MKCoordinateSpan theSpan;
	
	theSpan.latitudeDelta = 0.05;
	theSpan.longitudeDelta = 0.05;
	
	MKCoordinateRegion theRegion;
	theRegion.center = [[locationMananger location]coordinate];
	theRegion.span = theSpan;
	[cityMapView setRegion:theRegion];
	[locationMananger release];

}

- (IBAction) OnSegmentIndexChanged:(id)sender{
	if ([sender selectedSegmentIndex] == 0){
		NSLog(@"--------------OnSegmentIndexChanged1-------");
		
		cityMapView.mapType = MKMapTypeStandard;
	}
	else if([sender selectedSegmentIndex] == 1){
		NSLog(@"--------------OnSegmentIndexChanged2-------");
		
		cityMapView.mapType = MKMapTypeSatellite;
	}
	else if([sender selectedSegmentIndex] == 2){
		NSLog(@"--------------OnSegmentIndexChanged3-------");
		
		cityMapView.mapType = MKMapTypeHybrid;
	}
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	NSInteger styleNum = [userDefault integerForKey:@"styleType"];
	
	switch (styleNum) {
		case 0:{
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
			self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
			self.mapStyleSegCtr.tintColor = [UIColor colorWithRed:0.48	green:0.56 blue:0.66 alpha:1.0];
			self.mapNavigationBar.barStyle = UIBarStyleDefault;
			break;
		}
		case 1:{
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
			self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
			self.mapStyleSegCtr.tintColor = [UIColor darkGrayColor];
			self.mapNavigationBar.barStyle = UIBarStyleBlackOpaque;
			break;
		}
	}
}

- (IBAction)goToWebMap:(id)sender
{
	CBus_WebMapViewController *theController = [[CBus_WebMapViewController alloc] initWithNibName:@"CBus_WebMapView" bundle:nil];
	self.webMapViewController = theController;
	
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
	[self.navigationController pushViewController:webMapViewController animated:YES];
	[UIView commitAnimations];
	
	[theController release];
	

}

- (void)viewDidUnload{
    [super viewDidUnload];
   }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
