//
//  LBHamburgerButton.swift
//  HamburgerButton
//
//  Created by Bang Nguyen on 03/09/2014.
//  Copyright (c) Năm 2014 Bang Nguyen. All rights reserved.
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

import UIKit
import QuartzCore

/**
* LBHamburgerButton is a sub-class of UIButton, displays a hamburger button
* and other state button without using image
*
* This is a simple button with 2 state. At initialization, it has state "Hamburger"
* which means 3 lines. After switch state, it has state "Not hamburger" and
* displays a back button/a close button.
*
* This button support 2 type:
* - BackButton - display <- after switch state
* - CloseButton - display X after switch state
*
* Those type can be setted when initialization or manually at any time/any event.
*
*/

enum LBHamburgerButtonType {
    case
    /** Show back (<-) button after switch state/animate. */
    BackButton,
    /** Show close (X) button after switch state/animate. */
    CloseButton
    
    // other type
    
}

enum LBHamburgerButtonState {
    case
    /** Initialize state, with 3 lines (hamburger). */
    Hamburger,
    /** State happened after animate. */
    NotHamburger
}

class LBHamburgerButton: UIButton {
    
    /**
    * Current state of hamburger button.
    */
    var hamburgerState = LBHamburgerButtonState.Hamburger
    
    /**
    * Type of hamburger button.
    */
    var hamburgerType = LBHamburgerButtonType.BackButton
    
    /**
    * Time for animation. Default is 0.5f.
    */
    var hamburgerAnimationDuration = 0.5
    
    private var _lineHeight : CGFloat = 50/6, _lineWidth : CGFloat = 50, _lineSpacing : CGFloat = 5
    private var _lineCenter : CGPoint
    private var _lineArray : [ CAShapeLayer ] = []
    private var _lineCreated = false
    
    // MARK:
    // MARK: Public functions
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(frame:CGRect, type:LBHamburgerButtonType, lineWidth:CGFloat, lineHeight:CGFloat, lineSpacing:CGFloat, lineCenter:CGPoint, color:UIColor) {
        
        _lineCenter = lineCenter
        
        super.init(frame: frame)
        
        self.setUpHamburger(type: type, lineWidth: lineWidth, lineHeight: lineHeight, lineSpacing: lineSpacing, lineCenter: lineCenter, color: color)
        
    }
    
    func setUpHamburger(#type:LBHamburgerButtonType, lineWidth:CGFloat, lineHeight:CGFloat, lineSpacing:CGFloat, lineCenter:CGPoint, color:UIColor) {
        
        if (_lineCreated) {
            // Lines have been created, do nothing.
            return;
        }
        
        hamburgerType = type
        _lineWidth = lineWidth
        _lineHeight = lineHeight
        _lineSpacing = lineSpacing
        _lineCenter = lineCenter
        
        var topLine = CAShapeLayer(frame: CGRectMake(0, 0, lineWidth, lineHeight), color: color, position: CGPointMake(lineCenter.x, lineCenter.y - lineHeight - lineSpacing))
        var middleLine = CAShapeLayer(frame: CGRectMake(0, 0, lineWidth, lineHeight), color: color, position: lineCenter)
        var bottomLine = CAShapeLayer(frame: CGRectMake(0, 0, lineWidth, lineHeight), color: color, position: CGPointMake(lineCenter.x, lineCenter.y + lineHeight + lineSpacing))
        
        _lineArray = [ topLine, middleLine, bottomLine]
        
        for layer in _lineArray {
            self.layer.addSublayer(layer)
        }
        
        _lineCreated = true;
    }
    
    func switchState() {
        animateButton(forward: hamburgerState == .Hamburger)
        hamburgerState = (hamburgerState == .Hamburger) ? .NotHamburger : .Hamburger
    }
    
    // MARK:
    // MARK: Private functions
    
    private func animateButton(#forward:Bool) {
        var anims = [ keyframeAnimations(lineIndex: 0, forward: forward), keyframeAnimations(lineIndex: 1, forward: forward), keyframeAnimations(lineIndex: 2, forward: forward) ]
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(hamburgerAnimationDuration)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0))
        
        var index = 0
        for animations in anims {
            var layer = _lineArray[index]
            for anim in animations! {
                if !anim.removedOnCompletion {
                    layer.addAnimation(anim, forKey: anim.keyPath)
                } else {
                    layer.addAnimation(anim, value: anim.values.last as NSValue, keyPath: anim.keyPath)
                }
            }
            index++
        }
        CATransaction.commit()
    }
    
    private func keyframeAnimations(#lineIndex:Int, forward:Bool) -> [CAKeyframeAnimation]? {
        switch hamburgerType {
        case .BackButton:
            switch lineIndex {
            case 0:
                var animRotate = CAKeyframeAnimation(keyPath: "transform.rotation")
                animRotate.values = forward ? [ 0, (M_PI*5/4) ] : [ (M_PI*5/4), 0]
                animRotate.calculationMode = kCAAnimationCubic
                animRotate.keyTimes = [ 0, 0.33, 0.73, 1.0]
                
                var startPoint = forward ? CGPointMake(_lineCenter.x, _lineCenter.y - _lineHeight - _lineSpacing) : CGPointMake(_lineCenter.x - scale(10), _lineCenter.y + _lineHeight + scale(7.2))
                var endPoint = forward ? CGPointMake(_lineCenter.x - scale(10), _lineCenter.y + _lineHeight + scale(7.2)) : CGPointMake(_lineCenter.x, _lineCenter.y - _lineHeight - _lineSpacing)
                var controlPoint = CGPointMake(_lineCenter.x + scale(15), _lineCenter.y)
                    
                var animPosition = CAKeyframeAnimation(keyPath: "position")
                animPosition.path = UIBezierPath.animateBezierPath(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint).CGPath
                animPosition.removedOnCompletion = false
                animPosition.fillMode = kCAFillModeForwards
                
                return [ animRotate, animPosition ]
            case 1:
                var animRotate = CAKeyframeAnimation(keyPath: "transform.rotation")
                animRotate.values = forward ? [ 0, (M_PI) ] : [ (M_PI), 0]
                
                return [ animRotate ]
            case 2:
                var animRotate = CAKeyframeAnimation(keyPath: "transform.rotation")
                animRotate.values = forward ? [ 0, (-M_PI*5/4) ] : [ (-M_PI*5/4), 0]
                animRotate.calculationMode = kCAAnimationCubic
                animRotate.keyTimes = [ 0, 0.33, 0.73, 1.0]
                
                var startPoint = forward ? CGPointMake(_lineCenter.x, _lineCenter.y + _lineHeight + _lineSpacing) : CGPointMake(_lineCenter.x - scale(10), _lineCenter.y - _lineHeight - scale(7.2))
                var endPoint = forward ? CGPointMake(_lineCenter.x - scale(10), _lineCenter.y - _lineHeight - scale(7.2)) : CGPointMake(_lineCenter.x, _lineCenter.y + _lineHeight + _lineSpacing)
                var controlPoint = CGPointMake(_lineCenter.x + scale(15), _lineCenter.y)
                
                var animPosition = CAKeyframeAnimation(keyPath: "position")
                animPosition.path = UIBezierPath.animateBezierPath(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint).CGPath
                animPosition.removedOnCompletion = false
                animPosition.fillMode = kCAFillModeForwards
                
                return [ animRotate, animPosition ]
            default:
                return nil
            }
        case .CloseButton:
            switch lineIndex {
            case 0:
                var animRotate = CAKeyframeAnimation(keyPath: "transform.rotation")
                animRotate.values = forward ? [ 0, (-M_PI*5/4) ] : [ (-M_PI*5/4), 0]
                animRotate.calculationMode = kCAAnimationCubic
                animRotate.keyTimes = [ 0, 0.33, 0.73, 1.0]
                
                var startPoint = forward ? CGPointMake(_lineCenter.x, _lineCenter.y - _lineHeight - _lineSpacing) : _lineCenter
                var endPoint = forward ? _lineCenter : CGPointMake(_lineCenter.x, _lineCenter.y - _lineHeight - _lineSpacing)
                var controlPoint = CGPointMake(_lineCenter.x + scale(20), _lineCenter.y - _lineHeight - scale(5))
                
                var animPosition = CAKeyframeAnimation(keyPath: "position")
                animPosition.path = UIBezierPath.animateBezierPath(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint).CGPath
                animPosition.removedOnCompletion = false
                animPosition.fillMode = kCAFillModeForwards
                
                return [ animRotate, animPosition ]
            case 1:
                var animRotate = CAKeyframeAnimation(keyPath: "transform.rotation")
                animRotate.values = forward ? [ 0, (M_PI) ] : [ (M_PI), 0]
                
                var animScale = CAKeyframeAnimation(keyPath: "transform.scale.x")
                animScale.values = forward ? [ 1, 0.1 ] : [ 0.1, 1 ]
                
                return [ animRotate, animScale ]
            case 2:
                var animRotate = CAKeyframeAnimation(keyPath: "transform.rotation")
                animRotate.values = forward ? [ 0, (M_PI*5/4) ] : [ (M_PI*5/4), 0]
                animRotate.calculationMode = kCAAnimationCubic
                animRotate.keyTimes = [ 0, 0.33, 0.73, 1.0]
                
                var startPoint = forward ? CGPointMake(_lineCenter.x, _lineCenter.y + _lineHeight + _lineSpacing) : _lineCenter
                var endPoint = forward ? _lineCenter : CGPointMake(_lineCenter.x, _lineCenter.y + _lineHeight + _lineSpacing)
                var controlPoint = CGPointMake(_lineCenter.x - scale(20), _lineCenter.y + _lineHeight + scale(5))
                
                var animPosition = CAKeyframeAnimation(keyPath: "position")
                animPosition.path = UIBezierPath.animateBezierPath(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint).CGPath
                animPosition.removedOnCompletion = false
                animPosition.fillMode = kCAFillModeForwards
                
                return [ animRotate, animPosition ]
            default:
                return nil
            }
        }
    }
    private func scale(value:CGFloat) -> CGFloat {
        return value/(50/_lineWidth)
    }
}

// MARK:

// MARK: Supporting Extension
// MARK:

// MARK: CAShapeLayer extension

extension CAShapeLayer {
    convenience init(frame:CGRect, color:UIColor, position:CGPoint) {
        
        self.init()
        
        var path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(frame.size.width, 0))
        
        self.path = path.CGPath
        self.lineWidth = frame.size.height
        self.strokeColor = color.CGColor
        
        var bound : CGPathRef = CGPathCreateCopyByStrokingPath(self.path, nil, self.lineWidth, kCGLineCapButt, kCGLineJoinMiter, self.miterLimit)
        self.bounds = CGPathGetBoundingBox(bound)
        
        self.position = position
    }
}

// MARK: CALayer extension

extension CALayer {

    func addAnimation(anim:CAAnimation!, value:NSValue!, keyPath:String!) {
        self.addAnimation(anim, forKey: keyPath)
        self.setValue(value, forKeyPath: keyPath)
    }
}

// MARK: UIBezierPath extension

extension UIBezierPath {

    class func animateBezierPath(#startPoint:CGPoint, endPoint:CGPoint, controlPoint:CGPoint) -> UIBezierPath {
        
        var path = UIBezierPath()
        path.moveToPoint(startPoint)
        path.addQuadCurveToPoint(endPoint, controlPoint: controlPoint)
        return path
    }
}
