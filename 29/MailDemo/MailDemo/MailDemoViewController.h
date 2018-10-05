//
//  MailDemoViewController.h
//  MailDemo
//
//  Created by 阿萨德 的 on 11-8-19.
//  Copyright 2011年 阿萨德是. All rights reserved.
//

//记得要导入MessageUI.Framework   #import <MessageUI/MessageUI.h>  代理：<MFMailComposeViewControllerDelegate>

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface MailDemoViewController : UIViewController<MFMailComposeViewControllerDelegate>{
    
}
//点击按钮后，触发这个方法  
-(void)sendEMail;
//可以发送邮件的话  
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;
@end
