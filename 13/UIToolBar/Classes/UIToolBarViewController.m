//
//  UIToolBarViewController.m
//  UIToolBar


#import "UIToolBarViewController.h"

@implementation UIToolBarViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(IBAction)ToolBarBtnAction{
	if(isClick == NO)
	{
		[ToolBarBtn setImage:[UIImage imageNamed:@"Pause.png"]];
		isClick = YES;
	}else {
		[ToolBarBtn setImage:[UIImage imageNamed:@"play.png"]];
		isClick = NO;
	}
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}
@end
