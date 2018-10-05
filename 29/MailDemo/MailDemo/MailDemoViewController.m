//
//  MailDemoViewController.m
//  MailDemo
//
//  Created by 阿萨德 的 on 11-8-19.
//  Copyright 2011年 阿萨德是. All rights reserved.
//

#import "MailDemoViewController.h"

@implementation MailDemoViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
//-------------------------------------------------------------------------------------

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];  
    button.frame = CGRectMake(0, 40, 320, 50);  
    [button setTitle: @"Mail" forState: UIControlStateNormal];  
    [button addTarget: self action: @selector(sendEMail) forControlEvents: UIControlEventTouchUpInside];  
    [self.view addSubview: button];  
}
//点击完send后  成功失败都弹框显示：
- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg   
{  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_   
                                                    message:msg   
                                                   delegate:nil   
                                          cancelButtonTitle:@"确定"   
                                          otherButtonTitles:nil];  
    [alert show];  
    [alert release];  
}
//点击Mail按钮后，触发这个方法  
-(void)sendEMail   
{  
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));  
    
    if (mailClass != nil)  
    {  
        if ([mailClass canSendMail])  
        {  
            [self displayComposerSheet];  
        }   
        else   
        {  
            [self launchMailAppOnDevice];  
        }  
    }   
    else   
    {  
        [self launchMailAppOnDevice];  
    }      
}  
//可以发送邮件的话  
-(void)displayComposerSheet   
{  
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];  
    
    mailPicker.mailComposeDelegate = self;  
    
    //设置主题  
    [mailPicker setSubject: @"eMail主题"];  
    
    // 添加发送者  
    NSArray *toRecipients = [NSArray arrayWithObject: @"first@example.com"];  
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];  
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com", nil];  
    [mailPicker setToRecipients: toRecipients];  
    [mailPicker setCcRecipients:ccRecipients];      
    //[picker setBccRecipients:bccRecipients];  
    
    // 添加图片  
    UIImage *addPic = [UIImage imageNamed: @"3.jpg"];  
    NSData *imageData = UIImagePNGRepresentation(addPic);            // png  
    // NSData *imageData = UIImageJPEGRepresentation(addPic, 1);    // jpeg  
    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"3.jpg"];  
    
    NSString *emailBody = @"eMail 正文";  
    [mailPicker setMessageBody:emailBody isHTML:YES];  
    
    [self presentModalViewController: mailPicker animated:YES];  
    [mailPicker release];  
}  
-(void)launchMailAppOnDevice  
{  
    NSString *recipients = @"mailto:first@example.com&subject=my email!";  
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";  
    NSString *body = @"&body=email body!";  
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];  
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];  
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];  
}  
- (void)mailComposeController:(MFMailComposeViewController *)controller   
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error   
{  
    NSString *msg;  
    
    switch (result)   
    {  
        case MFMailComposeResultCancelled:  
            msg = @"邮件发送取消";  
            break;  
        case MFMailComposeResultSaved:  
            msg = @"邮件保存成功";  
            [self alertWithTitle:nil msg:msg];  
            break;  
        case MFMailComposeResultSent:  
            msg = @"邮件发送成功";  
            [self alertWithTitle:nil msg:msg];  
            break;  
        case MFMailComposeResultFailed:  
            msg = @"邮件发送失败";  
            [self alertWithTitle:nil msg:msg];  
            break;  
        default:  
            break;  
    }  
    
    [self dismissModalViewControllerAnimated:YES];  
}  
//-------------------------------------------------------------------------------------



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
