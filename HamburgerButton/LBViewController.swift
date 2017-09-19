//
//  LBViewController.swift
//  HamburgerButton
//
//  Created by Bang Nguyen on 03/09/2014.
//  Converted to Swift 3 by Nikolay Khramchenko 9/19/2017.
//  Copyright (c) Năm 2014 Bang Nguyen. All rights reserved.
//

import UIKit

class LBViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let hamburgerButtonCloseBig = LBHamburgerButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100), type: LBHamburgerButtonType.closeButton, lineWidth: 50, lineHeight: 50/6, lineSpacing: 5, lineCenter: CGPoint(x: 50, y: 50), color: UIColor.white)
        hamburgerButtonCloseBig.center = CGPoint(x: 120, y: 120)
        hamburgerButtonCloseBig.backgroundColor = UIColor.black
        hamburgerButtonCloseBig.addTarget(self, action: #selector(LBViewController.buttonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(hamburgerButtonCloseBig)
        
        let hamburgerButtonCloseSmall = LBHamburgerButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: LBHamburgerButtonType.closeButton, lineWidth: 20, lineHeight: 20/6, lineSpacing: 2, lineCenter: CGPoint(x: 25, y: 25), color: UIColor.white)
        hamburgerButtonCloseSmall.center = CGPoint(x: hamburgerButtonCloseBig.center.x + 100, y: 120)
        hamburgerButtonCloseSmall.backgroundColor = UIColor.black
        hamburgerButtonCloseSmall.addTarget(self, action: #selector(LBViewController.buttonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(hamburgerButtonCloseSmall)
        
        let hamburgerButtonBackBig = LBHamburgerButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100), type: LBHamburgerButtonType.backButton, lineWidth: 50, lineHeight: 50/6, lineSpacing: 5, lineCenter: CGPoint(x: 50, y: 50), color: UIColor.white)
        hamburgerButtonBackBig.center = CGPoint(x: 120, y: hamburgerButtonCloseBig.center.y + 120)
        hamburgerButtonBackBig.backgroundColor = UIColor.black
        hamburgerButtonBackBig.addTarget(self, action: #selector(LBViewController.buttonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(hamburgerButtonBackBig)
        
        let hamburgerButtonBackSmall = LBHamburgerButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: LBHamburgerButtonType.backButton, lineWidth: 20, lineHeight: 20/6, lineSpacing: 2, lineCenter: CGPoint(x: 25, y: 25), color: UIColor.white)
        hamburgerButtonBackSmall.center = CGPoint(x: hamburgerButtonBackBig.center.x + 100, y: hamburgerButtonBackBig.center.y)
        hamburgerButtonBackSmall.backgroundColor = UIColor.black
        hamburgerButtonBackSmall.addTarget(self, action: #selector(LBViewController.buttonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(hamburgerButtonBackSmall)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let btn = sender as! LBHamburgerButton
        btn.switchState()
    }
    
}
