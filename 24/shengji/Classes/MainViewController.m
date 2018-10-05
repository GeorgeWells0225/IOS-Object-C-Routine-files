//
//  MainViewController.m
//  WhereAmI


#import "MainViewController.h"


@implementation MainViewController

@synthesize altitude,latitude,longitude,locmanager;

- (IBAction)openWebMap {

    
    NSString *urlString = [NSString stringWithFormat:
                           @"http://maps.google.com/maps?q=%f,%f", 
                           [latitude.text floatValue], 
                           [longitude.text floatValue]];

    NSURL *url = [NSURL URLWithString:urlString];
    
    [[UIApplication sharedApplication] openURL:url];
	
}

- (IBAction)update {
	
	locmanager = [[CLLocationManager alloc] init]; 
	[locmanager setDelegate:self]; 
	[locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
	
	[locmanager startUpdatingLocation];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self update];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation 
{ 
	if (wasFound) return; 
	wasFound = YES;
	
	CLLocationCoordinate2D loc = [newLocation coordinate];
	
	latitude.text = [NSString stringWithFormat: @"%f", loc.latitude];
	longitude.text	= [NSString stringWithFormat: @"%f", loc.longitude];
	altitude.text = [NSString stringWithFormat: @"%f", newLocation.altitude];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error { 
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误通知" 
													message:[error description] 
												   delegate:nil cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil];
	[alert show];
	[alert release];	
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    
	
	CLLocation *lastLocation = [locmanager location];
    if(!lastLocation) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] 
                 initWithTitle:@"系统错误" 
                 message:@"还没有接收到数据！" 
                 delegate:nil cancelButtonTitle:nil 
                 otherButtonTitles:@"OK", nil];
        
        [alert show];
        [alert release];
        return;
    }
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	controller.lastLocation = lastLocation;
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	[locmanager stopUpdatingLocation];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
	[altitude release];
	[latitude release];
	[longitude release];
	[locmanager release];
    [super dealloc];
}


@end
