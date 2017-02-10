//
//  MMWaveView.m
//  CADisplayLinkDemo
//
//  Created by wyy on 16/11/15.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import "MMWaveView.h"
#define waveFillColor [[UIColor colorWithRed:118/255.0 green:178/255.0 blue:252/255.0 alpha:1] CGColor]
static const CGFloat arrowInitializationDistanceToRightEdge = 20.0f;
static const CGFloat arrowInitializationDistanceToLeft = 20.0f;
static const CGFloat arrowLineWidth = 3.0;
static const NSInteger rate = 4;

@interface MMWaveView ()
@property (nonatomic, strong) CAShapeLayer *waveLayer;
@property (nonatomic, strong) CAShapeLayer *arrowLayer;
@property (nonatomic, assign) BOOL isAnimation;
@property (nonatomic, assign) CGFloat maxX;
@end

@implementation MMWaveView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isAnimation = NO;
        [self.layer addSublayer:self.waveLayer];
        [self.layer addSublayer:self.arrowLayer];
        [self _addPanGestureRecognizer];
    }
    return self;
}


#pragma mark - private method
- (void)_addPanGestureRecognizer{
    UIScreenEdgePanGestureRecognizer*panGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPanGestureRecognizerAction:)];
    panGestureRecognizer.edges = UIRectEdgeRight;
    [self addGestureRecognizer:panGestureRecognizer];
}

#pragma mark - gesture event
- (void)respondToPanGestureRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint point = [gestureRecognizer translationInView:self];

    if (gestureRecognizer.state == UIGestureRecognizerStateBegan ||self.isAnimation == NO) {
        self.isAnimation = YES;
        self.waveLayer.path = [self getWaveLinePathWithLeftPositionX:0.0];
    }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        self.waveLayer.path = [self getWaveLinePathWithLeftPositionX:fabs(point.x)];
        self.arrowLayer.path = [self getRightArrowPathWithPositionX:fabs(point.x)];
        
        self.maxX = fabs(point.x);
    }else if(gestureRecognizer.state == UIGestureRecognizerStateCancelled ||gestureRecognizer.state == UIGestureRecognizerStateEnded ||gestureRecognizer.state == UIGestureRecognizerStateFailed){
        self.isAnimation = NO;
    
        if ([self.delegate respondsToSelector:@selector(waveViewTriggerAction:)] && (self.maxX >=(arrowInitializationDistanceToRightEdge + arrowInitializationDistanceToRightEdge) * rate)) {
             self.arrowLayer.path = [self getRightArrowPathWithPositionX:0.0];
             self.waveLayer.path = [self getWaveLinePathWithLeftPositionX:0.0];
            [self.delegate waveViewTriggerAction:self];
        }else{
            [self waveAnimationWithPositionX:fabs(self.maxX)];
            [self arrowAnimationWithPositionX:fabs(self.maxX)];
        }
        self.maxX = 0.0f;
    }
    
    
}
#pragma mark - get CGPathRef
-(CGPathRef)getWaveLinePathWithLeftPositionX:(CGFloat)positionX{
    UIBezierPath *waveLine = [UIBezierPath bezierPath];
    CGPoint topPoint = CGPointMake(self.bounds.size.width , 0);
    CGPoint midControlPoint = CGPointMake(self.bounds.size.width - positionX, self.bounds.size.height/2);
    CGPoint bottomPoint = CGPointMake(self.bounds.size.width , self.bounds.size.height);
    
    [waveLine moveToPoint:topPoint];
    [waveLine addQuadCurveToPoint:bottomPoint controlPoint:midControlPoint];
    [waveLine closePath];
    
    return [waveLine CGPath];
}

/**
 * draw the arrow path
 */
- (CGPathRef)getRightArrowPathWithPositionX:(CGFloat)positionX{
    UIBezierPath *arrowLine = [UIBezierPath bezierPath];
    CGPoint point1 = CGPointMake(self.bounds.size.width + arrowInitializationDistanceToRightEdge , self.bounds.size.height/2);
    CGPoint point2 = CGPointMake(self.bounds.size.width - positionX/rate + arrowInitializationDistanceToRightEdge , self.bounds.size.height/2);
    CGPoint point3 = CGPointMake(self.bounds.size.width - positionX/rate  + arrowInitializationDistanceToLeft + arrowInitializationDistanceToRightEdge, self.bounds.size.height/2 - 20);
    CGPoint point4 = CGPointMake(self.bounds.size.width - positionX/rate + arrowInitializationDistanceToRightEdge - 2 , self.bounds.size.height/2);
    CGPoint point5 = CGPointMake(self.bounds.size.width - positionX/rate + arrowInitializationDistanceToLeft + arrowInitializationDistanceToRightEdge, self.bounds.size.height/2 + 20);
    
    [arrowLine moveToPoint:point1];
    [arrowLine addLineToPoint:point2];
    [arrowLine addLineToPoint:point3];
    [arrowLine moveToPoint:point4];
    [arrowLine addLineToPoint:point5];
    return [arrowLine CGPath];
}

#pragma mark - animation
- (void)waveAnimationWithPositionX:(CGFloat)positionX {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    NSArray *values = @[
                        (id) [self getWaveLinePathWithLeftPositionX:positionX],
                        (id) [self getWaveLinePathWithLeftPositionX:0.0]
                        ];
    keyAnimation.values = values;
    keyAnimation.duration = .5;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.delegate = self;
    [self.waveLayer addAnimation:keyAnimation forKey:@"wave_right"];
    
}

- (void)arrowAnimationWithPositionX:(CGFloat)positionX {
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    NSArray *values = @[
                        (id) [self getRightArrowPathWithPositionX:positionX],
                        (id) [self getRightArrowPathWithPositionX:0.0]
                        ];
    keyAnimation.values = values;
    keyAnimation.duration = .5;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.delegate = self;
    [self.arrowLayer addAnimation:keyAnimation forKey:@"arrow_right"];
    
}

#pragma mark  - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (anim == [self.arrowLayer animationForKey:@"arrow_right"] ) {
        self.arrowLayer.path = [self getRightArrowPathWithPositionX:0.0];
        [self.arrowLayer removeAllAnimations];
        
    }else if(anim == [self.waveLayer animationForKey:@"wave_right"]){
        self.waveLayer.path = [self getWaveLinePathWithLeftPositionX:0.0];
        [self.waveLayer removeAllAnimations];
     
    }
    [self _addPanGestureRecognizer];
}

#pragma mark - get
- (CAShapeLayer *)waveLayer{
    if (_waveLayer == nil) {
        _waveLayer = [CAShapeLayer layer];
        _waveLayer.strokeColor = [[UIColor clearColor] CGColor];
        _waveLayer.lineWidth = 1.0;
        _waveLayer.fillColor = waveFillColor;
      
    }
    return _waveLayer;
}

- (CAShapeLayer *)arrowLayer{
    if (_arrowLayer == nil) {
        _arrowLayer = [CAShapeLayer layer];
        _arrowLayer.lineWidth = arrowLineWidth;
        _arrowLayer.fillColor = [UIColor clearColor].CGColor;
        _arrowLayer.strokeColor = [[UIColor whiteColor] CGColor];
    }
    return _arrowLayer;
}
@end
