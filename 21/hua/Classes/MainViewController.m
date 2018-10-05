

#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIImageView* FireView = [[UIImageView alloc] initWithFrame:self.view.frame];
	
	FireView.animationImages = [NSArray arrayWithObjects:	
								[UIImage imageNamed:@"fire01.png"],
								[UIImage imageNamed:@"fire02.png"],
								[UIImage imageNamed:@"fire03.png"],
								[UIImage imageNamed:@"fire04.png"],
								[UIImage imageNamed:@"fire05.png"],
								nil];
	
	FireView.animationDuration = 1.75;
	
	FireView.animationRepeatCount = 0; 
	
	[FireView startAnimating];
	
	[self.view addSubview:FireView];
	
	[FireView release];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewDidUnload {

}
- (void)dealloc {
    [super dealloc];
}
@end
