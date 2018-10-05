
#import "UIKitPrjTouchesTheLabel.h"

#pragma mark ----- TouchableLabel -----

// 定义UILabel的子类
@interface TouchableLabel : UILabel
@end 

// 只追加touchesBegan:withEvent:方法
@implementation TouchableLabel

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:nil
                                                   message:@"这是一段文字!"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil] autorelease];
  [alert show];
}

@end 

#pragma mark ----- UIKitPrjTouchesTheLabel -----

@implementation UIKitPrjTouchesTheLabel

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  // 将新创建的标签布置在画面上
  TouchableLabel* label = [[[TouchableLabel alloc] init] autorelease];
  label.frame = CGRectMake( 60, 100, 200, 50 );
  label.text = @"触摸我吧!";
  label.textAlignment = UITextAlignmentCenter;
  label.backgroundColor = [UIColor grayColor];
  // 必须将userInteractionEnabled属性设置成YES，默认为NO
  label.userInteractionEnabled = YES;
  [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:nil
                                                   message:@"这是一个viewController!"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil] autorelease];
  [alert show];
}

@end
