//
//  UIKitPrjTextView.m

#import "UIKitPrjTextView.h"

@implementation UIKitPrjTextView

- (void)viewDidLoad {
  [super viewDidLoad];

  UITextView* textView = [[[UITextView alloc] init] autorelease];
  textView.frame = self.view.bounds;
  textView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  //textView.editable = NO; //< 不可编辑

  textView.backgroundColor = [UIColor blackColor]; //< 背景为黑色
  textView.textColor = [UIColor whiteColor]; //< 字符为白色
  textView.font = [UIFont systemFontOfSize:32]; //< 字体的设置
  textView.text = @"学习UITextView!\n"
                   "第2行\n"
                   "第3行\n"
                   "4行\n"
                   "第5行\n"
                   "第6行\n"
                   "第7行\n"
                   "第8行\n"
                   "第9行\n"
                   "第10行\n"
                   "第11行\n"
                   "第12行\n";

  [self.view addSubview:textView];
}

@end
