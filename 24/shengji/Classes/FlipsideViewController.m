//
//  FlipsideViewController.m


#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate;
@synthesize lastLocation;
@synthesize mapView;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor]; 
	
	mapView.mapType = MKMapTypeStandard;
	// mapView.mapType = MKMapTypeSatellite;
	//mapView.mapType = MKMapTypeHybrid;
	mapView.delegate = self;
}


- (IBAction)search:(id)sender {
	
	MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(lastLocation.coordinate, 2000, 2000); 
	[mapView setRegion:viewRegion animated:YES];
	
    MKReverseGeocoder *geocoder = [[MKReverseGeocoder alloc] initWithCoordinate:lastLocation.coordinate];
    geocoder.delegate = self;
    [geocoder start];
}

- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
	[lastLocation release];
	[mapView release];
    [super dealloc];
}

#pragma mark -
#pragma mark Reverse Geocoder Delegate Methods
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"地理解码错误息"
                          message: [error description] 
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    geocoder.delegate = nil;
    [geocoder autorelease];
	
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
    
    MapLocation *annotation = [[MapLocation alloc] init];
    annotation.streetAddress = placemark.thoroughfare;
    annotation.city = placemark.locality;
    annotation.state = placemark.administrativeArea;
    annotation.zip = placemark.postalCode;
    annotation.coordinate = geocoder.coordinate;
	
	[mapView removeAnnotations:mapView.annotations];
	
	[mapView addAnnotation:annotation];    
    
	[annotation release];    
    geocoder.delegate = nil;
    [geocoder autorelease];
	
}


#pragma mark -
#pragma mark Map View Delegate Methods
- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>) annotation {
	
	MKPinAnnotationView *annotationView 
	= (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
	if(annotationView == nil) {
		annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
														  reuseIdentifier:@"PIN_ANNOTATION"] autorelease];
	}

	annotationView.pinColor = MKPinAnnotationColorPurple;
	annotationView.animatesDrop = YES;
	annotationView.canShowCallout = YES;
	
	return annotationView;
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)theMapView withError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"地图加载错误"
                          message:[error localizedDescription] 
                          delegate:nil 
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}


@end
