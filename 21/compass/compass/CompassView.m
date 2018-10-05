

#import "CompassView.h"
#import "CompassLayer.h"
@implementation CompassView
@synthesize view;

+ (Class) layerClass { 
    return [CompassLayer class];
}

@end
