

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (BNRQuickConstraints)

+ (NSArray *)bnr_constraintsWithCommaDelimitedFormat:(NSString *)format views:(NSDictionary *)views;

@end
