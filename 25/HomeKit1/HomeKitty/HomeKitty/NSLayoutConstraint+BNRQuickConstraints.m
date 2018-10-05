

#import "NSLayoutConstraint+BNRQuickConstraints.h"

@implementation NSLayoutConstraint (BNRQuickConstraints)

+ (NSArray *)bnr_constraintsWithCommaDelimitedFormat:(NSString *)format views:(NSDictionary *)views {
    NSMutableArray *constraints = [NSMutableArray array];
    
    NSArray *formats = [format componentsSeparatedByString:@","];
    for (NSString *aFormat in formats) {
        [constraints addObjectsFromArray:[self constraintsWithVisualFormat:aFormat options:0 metrics:nil views:views]];
    }
    
    return [constraints copy];
}

@end
