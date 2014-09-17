//
//  LBHamburgerButton.m
//  HamburgerButton
//
//  Created by Bang Nguyen on 26/07/2014.
//  Copyright (c) Năm 2014 Bang Nguyen. All rights reserved.
//

#import "LBHamburgerButton.h"

@interface LBHamburgerButton () {
    
    CGFloat _lineHeight, _lineWidth, _lineSpacing;
    CGPoint _lineCenter;
    NSArray* _lineArray;
    BOOL _lineCreated;
    
}

@end

@implementation LBHamburgerButton

#pragma mark -
#pragma mark - Public functions

- (instancetype)initWithFrame:(CGRect)frame withHamburgerType:(LBHamburgerButtonType)type lineWidth:(CGFloat)lineWidth lineHeight:(CGFloat)lineHeight lineSpacing:(CGFloat)lineSpacing lineCenter:(CGPoint)lineCenter color:(UIColor *)color {
    
    if (self = [super initWithFrame:frame]) {
        
        _hamburgerAnimationDuration = 0.5;
        _hamburgerState = LBHamburgerButtonStateHamburger;
        
        [self setUpHamburgerWithType:type
                           lineWidth:lineWidth
                          lineHeight:lineHeight
                         lineSpacing:lineSpacing
                          lineCenter:lineCenter
                               color:color];
    }
    return self;
}

- (void)setUpHamburgerWithType:(LBHamburgerButtonType)type lineWidth:(CGFloat)lineWidth lineHeight:(CGFloat)lineHeight lineSpacing:(CGFloat)lineSpacing lineCenter:(CGPoint)lineCenter color:(UIColor *)color {
    
    if (_lineCreated) {
        // Lines have been created, do nothing.
        return;
    }
    
    _hamburgerType = type;
    _lineWidth = lineWidth;
    _lineHeight = lineHeight;
    _lineSpacing = lineSpacing;
    _lineCenter = lineCenter;
    
    CAShapeLayer* topLine = [self createLayerWithFrame:CGRectMake(0, 0, lineWidth, lineHeight) andColor:color atPosition:CGPointMake(lineCenter.x, lineCenter.y - lineHeight - lineSpacing)];
    CAShapeLayer* middleLine = [self createLayerWithFrame:CGRectMake(0, 0, lineWidth, lineHeight) andColor:color atPosition:lineCenter];
    CAShapeLayer* bottomLine = [self createLayerWithFrame:CGRectMake(0, 0, lineWidth, lineHeight) andColor:color atPosition:CGPointMake(lineCenter.x, lineCenter.y + lineHeight + lineSpacing)];
    
    _lineArray = @[ topLine, middleLine, bottomLine ];
    for (CAShapeLayer* layer in _lineArray) {
        [self.layer addSublayer:layer];
    }
    _lineCreated = YES;
}

- (void)switchState {
    [self animateButtonForward:(_hamburgerState == LBHamburgerButtonStateHamburger)];
    _hamburgerState = (_hamburgerState == LBHamburgerButtonStateHamburger) ? LBHamburgerButtonStateNotHamburger : LBHamburgerButtonStateHamburger;
}

-(void)setState:(LBHamburgerButtonState)state
{
    if(_hamburgerState == state)
        return;
    else
        [self switchState];
}

#pragma mark -
#pragma mark - Private functions

- (void)animateButtonForward:(BOOL)forward {
    
    NSArray* anims = @[ [self keyframeAnimationsOfLineIndex:0 forward:forward],
                        [self keyframeAnimationsOfLineIndex:1 forward:forward],
                        [self keyframeAnimationsOfLineIndex:2 forward:forward] ];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:_hamburgerAnimationDuration];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    for (NSArray* animations in anims) {
        NSInteger index = [anims indexOfObject:animations];
        for (CAKeyframeAnimation* anim in animations) {
            CAShapeLayer* layer = _lineArray[index];
            if (!anim.removedOnCompletion) {
                [layer addAnimation:anim forKey:anim.keyPath];
            } else {
                [layer addAnimation:anim andValue:anim.values.lastObject forKeyPath:anim.keyPath];
            }
        }
    }
    
    [CATransaction commit];
}

- (NSArray*)keyframeAnimationsOfLineIndex:(NSInteger)index forward:(BOOL)forward {
    
    switch (_hamburgerType) {
        case LBHamburgerButtonTypeBackButton:
        {
            switch (index) {
                case 0:
                {
                    CAKeyframeAnimation* animRotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
                    animRotate.values = forward ? @[ @0, @(M_PI*5/4) ] : @[ @(M_PI*5/4), @0];
                    animRotate.calculationMode = kCAAnimationCubic;
                    animRotate.keyTimes = @[ @0, @0.33, @0.73, @1.0];
                    
                    CGPoint startPoint = forward ? CGPointMake(_lineCenter.x, _lineCenter.y - _lineHeight - _lineSpacing) : CGPointMake(_lineCenter.x - [self scale:10], _lineCenter.y + _lineHeight + [self scale:7.2]);
                    CGPoint endPoint = forward ? CGPointMake(_lineCenter.x - [self scale:10], _lineCenter.y + _lineHeight + [self scale:7.2]) : CGPointMake(_lineCenter.x, _lineCenter.y - _lineHeight - _lineSpacing);
                    CGPoint controlPoint = CGPointMake(_lineCenter.x + [self scale:15], _lineCenter.y);
                    
                    CAKeyframeAnimation* animPosition = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                    animPosition.path = [UIBezierPath animateBezierPathFrom:startPoint toPoint:endPoint controlPoint:controlPoint].CGPath;
                    animPosition.removedOnCompletion = NO;
                    animPosition.fillMode = kCAFillModeForwards;
                    
                    return @[ animRotate, animPosition ];
                }
                case 1:
                {
                    CAKeyframeAnimation* animRotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
                    animRotate.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0];
                    
                    return @[ animRotate ];
                }
                case 2:
                {
                    CAKeyframeAnimation* animRotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
                    animRotate.values = forward ? @[ @0, @(-M_PI*5/4) ] : @[ @(-M_PI*5/4), @0];
                    animRotate.calculationMode = kCAAnimationCubic;
                    animRotate.keyTimes = @[ @0, @0.33, @0.73, @1.0];
                    
                    CGPoint startPoint = forward ? CGPointMake(_lineCenter.x, _lineCenter.y + _lineHeight + _lineSpacing) : CGPointMake(_lineCenter.x - [self scale:10], _lineCenter.y - _lineHeight - [self scale:7.2]);
                    CGPoint endPoint = forward ? CGPointMake(_lineCenter.x - [self scale:10], _lineCenter.y - _lineHeight - [self scale:7.2]) : CGPointMake(_lineCenter.x, _lineCenter.y + _lineHeight + _lineSpacing);
                    CGPoint controlPoint = CGPointMake(_lineCenter.x + [self scale:15], _lineCenter.y);
                    
                    CAKeyframeAnimation* animPosition = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                    animPosition.path = [UIBezierPath animateBezierPathFrom:startPoint toPoint:endPoint controlPoint:controlPoint].CGPath;
                    animPosition.removedOnCompletion = NO;
                    animPosition.fillMode = kCAFillModeForwards;
                    
                    return @[ animRotate, animPosition ];
                }
                default:
                    break;
            }
            break;
        }
        case LBHamburgerButtonTypeCloseButton:
        {
            switch (index) {
                case 0:
                {
                    CAKeyframeAnimation* animRotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
                    animRotate.values = forward ? @[ @0, @(-M_PI*5/4) ] : @[ @(-M_PI*5/4), @0];
                    animRotate.calculationMode = kCAAnimationCubic;
                    animRotate.keyTimes = @[ @0, @0.33, @0.73, @1.0];
                    
                    CGPoint startPoint = forward ? CGPointMake(_lineCenter.x, _lineCenter.y - _lineHeight - _lineSpacing) : _lineCenter;
                    CGPoint endPoint = forward ? _lineCenter : CGPointMake(_lineCenter.x, _lineCenter.y - _lineHeight - _lineSpacing);
                    CGPoint controlPoint = CGPointMake(_lineCenter.x + [self scale:20], _lineCenter.y - _lineHeight - [self scale:5]);
                    
                    CAKeyframeAnimation* animPosition = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                    animPosition.path = [UIBezierPath animateBezierPathFrom:startPoint toPoint:endPoint controlPoint:controlPoint].CGPath;
                    animPosition.removedOnCompletion = NO;
                    animPosition.fillMode = kCAFillModeForwards;
                    
                    return @[ animRotate, animPosition ];
                }
                case 1:
                {
                    CAKeyframeAnimation* animRotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
                    animRotate.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0];
                    
                    CAKeyframeAnimation* animScale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
                    animScale.values = forward ? @[ @1, @0.1 ] : @[ @0.1, @1 ];
                    
                    return @[ animRotate, animScale ];
                }
                case 2:
                {
                    CAKeyframeAnimation* animRotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
                    animRotate.values = forward ? @[ @0, @(M_PI*5/4) ] : @[ @(M_PI*5/4), @0];
                    animRotate.calculationMode = kCAAnimationCubic;
                    animRotate.keyTimes = @[ @0, @0.33, @0.73, @1.0];
                    
                    CGPoint startPoint = forward ? CGPointMake(_lineCenter.x, _lineCenter.y + _lineHeight + _lineSpacing) : _lineCenter;
                    CGPoint endPoint = forward ? _lineCenter : CGPointMake(_lineCenter.x, _lineCenter.y + _lineHeight + _lineSpacing);
                    CGPoint controlPoint = CGPointMake(_lineCenter.x - [self scale:20], _lineCenter.y + _lineHeight + [self scale:5]);
                    
                    CAKeyframeAnimation* animPosition = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                    animPosition.path = [UIBezierPath animateBezierPathFrom:startPoint toPoint:endPoint controlPoint:controlPoint].CGPath;
                    animPosition.removedOnCompletion = NO;
                    animPosition.fillMode = kCAFillModeForwards;
                    
                    return @[ animRotate, animPosition ];
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    return nil;
}

- (CAShapeLayer*)createLayerWithFrame:(CGRect)frame andColor:(UIColor*)color atPosition:(CGPoint)point {
    
    CAShapeLayer* layer = [CAShapeLayer new];
    
    UIBezierPath* path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(frame.size.width, 0)];
    
    layer.path = path.CGPath;
    layer.lineWidth = frame.size.height;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}

- (CGFloat)scale:(CGFloat)value {
    return value/(50/_lineWidth);
}

@end

#pragma mark -
#pragma mark - Supporting Category
#pragma mark - CALayer

@implementation CALayer (LBAddAnimationAndValue)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath {
    [self addAnimation:anim forKey:keyPath];
    [self setValue:value forKeyPath:keyPath];
}

@end

#pragma mark - UIBezierPath

@implementation UIBezierPath (LBAnimateBezierPath)

+ (UIBezierPath*)animateBezierPathFrom:(CGPoint)startPoint toPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint {
    
    UIBezierPath* path = [UIBezierPath new];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    return path;
}

@end
