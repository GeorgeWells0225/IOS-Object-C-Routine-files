

#import "UIKitPrjMotion.h"
//实现UILabel的子类
@implementation LabelForMotion

- (BOOL)canBecomeFirstResponder {
  return YES;
}

@end
//实现UIViewController的子类
@implementation UIKitPrjMotion

- (void)viewDidLoad {
  [super viewDidLoad];
  //创建新标签并追加到画面中
  LabelForMotion* label = [[[LabelForMotion alloc] init] autorelease];
  label.frame = self.view.bounds;
  label.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  label.textAlignment = UITextAlignmentCenter;
  label.text = @"摇动我吧!";
  [self.view addSubview:label];
  //将标签设置为第一响应者
  [label becomeFirstResponder];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent*)event {
  NSLog( @"开始了！" );
}
//振动结束时调用的方法
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event {
  NSLog( @"结束了" );
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:nil
                                                   message:@"地震了！！"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil] autorelease];
  [alert show];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent*)event {
  NSLog( @"取消吧" );
}

@end
