//
//  LBViewController.swift
//  HamburgerButton
//
//  Created by Bang Nguyen on 03/09/2014.
//  Copyright (c) Năm 2014 Bang Nguyen. All rights reserved.
//

import UIKit

class LBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var hamburgerButtonCloseBig = LBHamburgerButton(frame: CGRectMake(0, 0, 100, 100), type: LBHamburgerButtonType.CloseButton, lineWidth: 50, lineHeight: 50/6, lineSpacing: 5, lineCenter: CGPointMake(50, 50), color: UIColor.whiteColor())
        hamburgerButtonCloseBig.center = CGPointMake(120, 120)
        hamburgerButtonCloseBig.backgroundColor = UIColor.blackColor()
        hamburgerButtonCloseBig.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(hamburgerButtonCloseBig)
        
        var hamburgerButtonCloseSmall = LBHamburgerButton(frame: CGRectMake(0, 0, 50, 50), type: LBHamburgerButtonType.CloseButton, lineWidth: 20, lineHeight: 20/6, lineSpacing: 2, lineCenter: CGPointMake(25, 25), color: UIColor.whiteColor())
        hamburgerButtonCloseSmall.center = CGPointMake(hamburgerButtonCloseBig.center.x + 100, 120)
        hamburgerButtonCloseSmall.backgroundColor = UIColor.blackColor()
        hamburgerButtonCloseSmall.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(hamburgerButtonCloseSmall)
        
        var hamburgerButtonBackBig = LBHamburgerButton(frame: CGRectMake(0, 0, 100, 100), type: LBHamburgerButtonType.BackButton, lineWidth: 50, lineHeight: 50/6, lineSpacing: 5, lineCenter: CGPointMake(50, 50), color: UIColor.whiteColor())
        hamburgerButtonBackBig.center = CGPointMake(120, hamburgerButtonCloseBig.center.y + 120)
        hamburgerButtonBackBig.backgroundColor = UIColor.blackColor()
        hamburgerButtonBackBig.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(hamburgerButtonBackBig)
        
        var hamburgerButtonBackSmall = LBHamburgerButton(frame: CGRectMake(0, 0, 50, 50), type: LBHamburgerButtonType.BackButton, lineWidth: 20, lineHeight: 20/6, lineSpacing: 2, lineCenter: CGPointMake(25, 25), color: UIColor.whiteColor())
        hamburgerButtonBackSmall.center = CGPointMake(hamburgerButtonBackBig.center.x + 100, hamburgerButtonBackBig.center.y)
        hamburgerButtonBackSmall.backgroundColor = UIColor.blackColor()
        hamburgerButtonBackSmall.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(hamburgerButtonBackSmall)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(sender: UIButton) {
        var btn = sender as LBHamburgerButton
        btn.switchState()
    }

}
