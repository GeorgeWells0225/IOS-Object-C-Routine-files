

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class CBus_WebMapViewController;

@interface CBus_MapViewController : UIViewController <CLLocationManagerDelegate>{
	MKMapView	*cityMapView;
	UINavigationBar	*mapNavigationBar;
	UISegmentedControl *mapStyleSegCtr;
	
	CBus_WebMapViewController *webMapViewController;
}

@property (nonatomic, retain) IBOutlet MKMapView			*cityMapView;
@property (nonatomic, retain) IBOutlet UISegmentedControl	*mapStyleSegCtr;
@property (nonatomic, retain) IBOutlet UINavigationBar		*mapNavigationBar;

@property (nonatomic, retain) CBus_WebMapViewController		*webMapViewController;

- (IBAction) OnSegmentIndexChanged:(id)sender;


@end
