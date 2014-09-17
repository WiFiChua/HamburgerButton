//
//  LBHamburgerButton.h
//  Version 1.0
//
//  Created by Bang Nguyen on 26/07/2014.
//

// This code is distributed under the terms and conditions of the MIT license.

// Copyright (c) 2014 Bang Nguyen
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    /** Show back (<-) button after switch state/animate. */
    LBHamburgerButtonTypeBackButton = 0,
    /** Show close (X) button after switch state/animate. */
    LBHamburgerButtonTypeCloseButton
    
    // other type
    
} LBHamburgerButtonType;

typedef enum {
    /** Initialize state, with 3 lines (hamburger). */
    LBHamburgerButtonStateHamburger = 0,
    /** State happened after animate. */
    LBHamburgerButtonStateNotHamburger
} LBHamburgerButtonState;

/**
 * LBHamburgerButton is a sub-class of UIButton, displays a hamburger button 
 * and other state button without using image
 *
 * This is a simple button with 2 state. At initialization, it has state "Hamburger" 
 * which means 3 lines. After switch state, it has state "Not hamburger" and 
 * displays a back button/a close button.
 *
 * This button support 2 type:
 * - LBHamburgerButtonTypeBackButton - display <- after switch state
 * - LBHamburgerButtonTypeCloseButton - display X after switch state
 *
 * Those type can be setted when initialization or manually at any time/any event.
 *
 */
@interface LBHamburgerButton : UIButton

/**
 * Current state of hamburger button.
 */
@property (readonly) LBHamburgerButtonState hamburgerState;

/**
 * Type of hamburger button.
 */
@property LBHamburgerButtonType hamburgerType;

/**
 * Time for animation. Default is 0.5f.
 */
@property CFTimeInterval hamburgerAnimationDuration;

/**
 * Full contructor that initializes the button with default state.
 *
 * @param frame Frame of the button in superview.
 * @param type Type of button, Back or Close or etc.
 * @param lineWidth Width of each line in hamburger.
 * @param lineHeight Height of each line in hamburger.
 * @param lineSpacing Distance between lines.
 * @param lineCenter Position of 2nd line in hamburger (which means center of group of 3)
 * @param color Color of lines.
 *
 */
- (instancetype)initWithFrame:(CGRect)frame
            withHamburgerType:(LBHamburgerButtonType)type
                    lineWidth:(CGFloat)lineWidth
                   lineHeight:(CGFloat)lineHeight
                  lineSpacing:(CGFloat)lineSpacing
                   lineCenter:(CGPoint)lineCenter
                        color:(UIColor*)color;

/**
 * Set up default state of button which has 3 lines.
 *
 * @param type Type of button, Back or Close or etc.
 * @param lineWidth Width of each line in hamburger.
 * @param lineHeight Height of each line in hamburger.
 * @param lineSpacing Distance between lines.
 * @param lineCenter Position of 2nd line in hamburger (which means center of group of 3)
 * @param color Color of lines.
 *
 */
- (void)setUpHamburgerWithType:(LBHamburgerButtonType)type
                     lineWidth:(CGFloat)lineWidth
                    lineHeight:(CGFloat)lineHeight
                   lineSpacing:(CGFloat)lineSpacing
                    lineCenter:(CGPoint)lineCenter
                         color:(UIColor*)color;

/**
 * Animate from current state to other state.
 */
- (void)switchState;

/**
 * Animate from current state to specfied state.
 */
- (void)setState:(LBHamburgerButtonState)state;

@end

/**
 * Supporting category of CALayer
 */
@interface CALayer (LBAddAnimationAndValue)

/**
 * Add both animation and its end value to CALayer
 */
- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue*)value forKeyPath:(NSString *)keyPath;

@end

/**
 * Supporting category of UIBezierPath
 * Helps creating a curve path for animation
 */
@interface UIBezierPath (LBAnimateBezierPath)

/**
 * Create a curve path with ease
 */
+ (UIBezierPath*)animateBezierPathFrom:(CGPoint)startPoint toPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;

@end

