

#import "CompassLayer.h"
#import <UIKit/UIKit.h>
@implementation CompassLayer


- (void) doRotate {
    NSLog(@"rotate");
    self->rotationLayer.anchorPoint = CGPointMake(1,0.5);
    self->rotationLayer.position = CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds));
    self->rotationLayer.transform = CATransform3DMakeRotation(M_PI/4.0, 0, 1, 0);
    
}

- (void) setup {
    NSLog(@"setup");
    
    [CATransaction setDisableActions:YES];
    
    // 构建3D空间图层
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/1000.0;
    self.sublayerTransform = transform;
    
    
    CATransformLayer* master = [CATransformLayer layer];
    master.frame = self.bounds;
    [self addSublayer: master];
    self->rotationLayer = master;
    
    
    // 梯度
    CAGradientLayer* g = [[CAGradientLayer alloc] init];
    g.frame = master.bounds;
    g.colors = [NSArray arrayWithObjects:
                (id)[[UIColor blackColor] CGColor],
                [[UIColor redColor] CGColor],
                nil];
    g.locations = [NSArray arrayWithObjects:
                   [NSNumber numberWithFloat: 0.0],
                   [NSNumber numberWithFloat: 1.0],
                   nil];
    [master addSublayer:g];
    
    // 圆
    CAShapeLayer* circle = [[CAShapeLayer alloc] init];
    circle.lineWidth = 2.0;
    circle.fillColor = 
    [[UIColor colorWithRed:0.9 green:0.95 blue:0.93 alpha:0.9] CGColor];
    circle.strokeColor = [[UIColor grayColor] CGColor];
    CGMutablePathRef p = CGPathCreateMutable();
    CGPathAddEllipseInRect(p, NULL, CGRectInset(self.bounds, 3, 3));
    circle.path = p;
    [master addSublayer:circle];
    circle.bounds = self.bounds;
    circle.position = CGPointMake(CGRectGetMidX(self.bounds), 
                                  CGRectGetMidY(self.bounds));
    
    circle.shadowOpacity = 0.4;
    
    // 四个基本点，指南针的东、南、西、北
    NSArray* pts = [NSArray arrayWithObjects: @"N", @"E", @"S", @"W", nil];
    for (int i = 0; i < 4; i++) {
        CATextLayer* t = [[CATextLayer alloc] init];
        t.string = [pts objectAtIndex: i];
        t.bounds = CGRectMake(0,0,40,30);
        t.position = CGPointMake(CGRectGetMidX(circle.bounds), 
                                 CGRectGetMidY(circle.bounds));
        CGFloat vert = (CGRectGetMidY(circle.bounds) - 5) / CGRectGetHeight(t.bounds);
        t.anchorPoint = CGPointMake(0.5, vert);
        t.alignmentMode = kCAAlignmentCenter;
        t.foregroundColor = [[UIColor blackColor] CGColor]; 
        [t setAffineTransform:CGAffineTransformMakeRotation(i*M_PI/2.0)];
        [circle addSublayer:t];
       
    }
    
    // 箭头
    CALayer* arrow = [[CALayer alloc] init];
    arrow.bounds = CGRectMake(0, 0, 40, 100);
    arrow.position = CGPointMake(CGRectGetMidX(self.bounds), 
                                 CGRectGetMidY(self.bounds));
    arrow.anchorPoint = CGPointMake(0.5, 0.8);
    arrow.delegate = self;
    [arrow setAffineTransform:CGAffineTransformMakeRotation(M_PI/5.0)];
    [master addSublayer:arrow];
    //阴影
    arrow.shadowOpacity = 1.0;
    arrow.shadowRadius = 10;
    
    [arrow setNeedsDisplay];
    
    // “挂”贴到箭头和圆圈
    CAShapeLayer* line = [[CAShapeLayer alloc] init];
    line.bounds = CGRectMake(0,0,3.5,50);
    CGMutablePathRef p2 = CGPathCreateMutable();
    CGPathAddRect(p2, NULL, line.bounds);
    line.path = p2;
    CGPathRelease(p2);
    line.fillColor = [[UIColor colorWithRed:1.0 green:0.95 blue:1.0 alpha:0.95] CGColor];
    line.anchorPoint = CGPointMake(0.5,0.5);
    line.position = CGPointMake(CGRectGetMidX(master.bounds), CGRectGetMidY(master.bounds));
    [master addSublayer: line];
    //使用键-值码改变或使用图层中的成分
    [line setValue:[NSNumber numberWithFloat: M_PI/2] forKeyPath:@"transform.rotation.x"];
    [line setValue:[NSNumber numberWithFloat: M_PI/2] forKeyPath:@"transform.rotation.z"];
    
    // 使用不同的深度值设置了渐变图层、圆圈图层和箭头图层
    circle.zPosition = 10;
    arrow.zPosition = 20;
    line.zPosition = 15;
    
    
    
}

void drawStripes (void *info, CGContextRef con) {
    // 4 x 4 单元格
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0,0,4,4));
    CGContextSetFillColorWithColor(con, [[UIColor blueColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0,0,4,2));
}

- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)con {
    
    NSLog(@"drawLayer:inContext: for arrow");
    
    // 裁剪区域三角孔背景
    CGContextMoveToPoint(con, 10, 100);
    CGContextAddLineToPoint(con, 20, 90);
    CGContextAddLineToPoint(con, 30, 100);
    CGContextClosePath(con);
    CGContextAddRect(con, CGRectMake(0,0,40,100));
    CGContextEOClip(con);    
    
    
    // 画一个黑色（默认）垂直线，箭头轴
    CGContextMoveToPoint(con, 20, 100);
    CGContextAddLineToPoint(con, 20, 19);
    CGContextSetLineWidth(con, 20);
    CGContextStrokePath(con);
    
    // 画一个三角形图案，箭头的指向
    CGColorSpaceRef sp = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace (con, sp);
    CGColorSpaceRelease (sp);
    CGPatternCallbacks callback = {
        0, &drawStripes, NULL
    };
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGPatternRef patt = CGPatternCreate(NULL,
                                        CGRectMake(0,0,4,4),
                                        tr,
                                        4, 4, 
                                        kCGPatternTilingConstantSpacingMinimalDistortion,
                                        true,
                                        &callback);
    CGFloat alph = 1.0;
    CGContextSetFillPattern(con, patt, &alph);
    CGPatternRelease(patt);
    CGContextMoveToPoint(con, 0, 25);
    CGContextAddLineToPoint(con, 20, 0);
    CGContextAddLineToPoint(con, 40, 25);
    CGContextFillPath(con);
    
}


- (void) layoutSublayers {
    static BOOL didSetup = NO;
    if (!didSetup) {
        didSetup = YES;
        [self setup];
        [self performSelector:@selector(doRotate) withObject:nil afterDelay:1.0];
    }
}


@end
