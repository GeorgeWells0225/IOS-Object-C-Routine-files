

#import "CBus_WebMapViewController.h"


@implementation CBus_WebMapViewController
@synthesize myWenView;

// 视图初始化
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.hidesBackButton = YES;
	
	
	UIBarButtonItem *mapButton = [[UIBarButtonItem alloc]
									 initWithTitle:@"Map"
									 style:UIBarButtonItemStyleBordered
									 target:self
									 action:@selector(goToMap:)];
	
    self.navigationItem.rightBarButtonItem = mapButton;
	
	NSMutableString *googleSearch = [NSMutableString stringWithFormat:@"http://ditu.google.cn/maps?f=d&source=s_d&saddr='西安市火车站'&daddr='西安市钟楼'&hl=zh&t=m&dirflg=h"];
	[myWenView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[googleSearch stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
	
    [mapButton release];
}

- (IBAction) goToMap:(id)sender
{
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
	[self.navigationController popViewControllerAnimated:NO];
	[UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	NSInteger styleNum = [userDefault integerForKey:@"styleType"];
	
	switch (styleNum) {
		case 0:{
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
			self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
			break;
		}
		case 1:{
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
			self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
			break;
		}
	}
}

- (void)didReceiveMemoryWarning {
    // 释放视图
    [super didReceiveMemoryWarning];

}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.myWenView=nil;
}

- (void)dealloc {
    [super dealloc];
	[self.myWenView release];

}

@end
