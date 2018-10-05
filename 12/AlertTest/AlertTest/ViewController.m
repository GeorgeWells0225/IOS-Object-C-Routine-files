

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Release any retained subviews of the main view.
    UIButton *test = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [test setFrame:CGRectMake(200, 200, 200, 200)];
    [test setTitle:@"弹出窗口" forState:UIControlStateNormal];
    [test addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
}

-(void) ButtonClicked:(id)sender
{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"puzzle_longbt_1.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"puzzle_longbt_2.png"] forState:UIControlStateHighlighted];
    [btn1 setFrame:CGRectMake(73, 180, 160, 48)];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"puzzle_longbt_1.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"puzzle_longbt_2.png"] forState:UIControlStateHighlighted];
    [btn2 setFrame:CGRectMake(263, 180, 160, 48)];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"puzzle_warning_bg.png"];
    UIImage *content = [UIImage imageNamed:@"puzzle_warning_sn.png"];
    JKCustomAlert * alert = [[JKCustomAlert alloc] initWithImage:backgroundImage contentImage:content ];
    
    alert.JKdelegate = self;
    [alert addButtonWithUIButton:btn1];
    [alert addButtonWithUIButton:btn2];
    [alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"button1 clicked");
            break;
        case 1:
            NSLog(@"button2 clicked");   
        default:
            break;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
