//
//  LBViewController.m
//  HamburgerButton
//
//  Created by Bang Nguyen on 26/07/2014.
//  Copyright (c) Năm 2014 Bang Nguyen. All rights reserved.
//

#import "LBViewController.h"
#import "LBHamburgerButton.h"

@interface LBViewController ()

@property (strong, nonatomic) LBHamburgerButton* buttonHamburgerClose;
@property (strong, nonatomic) LBHamburgerButton* buttonHamburgerBack;

@property (strong, nonatomic) LBHamburgerButton* buttonHamburgerCloseSmall;
@property (strong, nonatomic) LBHamburgerButton* buttonHamburgerBackSmall;

@end

@implementation LBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _buttonHamburgerClose = [[LBHamburgerButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)
                                                   withHamburgerType:LBHamburgerButtonTypeCloseButton
                                                           lineWidth:50
                                                          lineHeight:50/6
                                                         lineSpacing:5
                                                          lineCenter:CGPointMake(50, 50)
                                                               color:[UIColor whiteColor]];
    [_buttonHamburgerClose setCenter:CGPointMake(120, 120)];
    [_buttonHamburgerClose setBackgroundColor:[UIColor blackColor]];
    [_buttonHamburgerClose addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_buttonHamburgerClose];
    
    _buttonHamburgerBack = [[LBHamburgerButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)
                                                  withHamburgerType:LBHamburgerButtonTypeBackButton
                                                          lineWidth:50
                                                         lineHeight:50/6
                                                        lineSpacing:5
                                                         lineCenter:CGPointMake(50, 50)
                                                              color:[UIColor whiteColor]];
    [_buttonHamburgerBack setCenter:CGPointMake(_buttonHamburgerClose.center.x, _buttonHamburgerClose.center.y + 120)];
    [_buttonHamburgerBack setBackgroundColor:[UIColor blackColor]];
    [_buttonHamburgerBack addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_buttonHamburgerBack];
    
    _buttonHamburgerCloseSmall = [[LBHamburgerButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)
                                                        withHamburgerType:LBHamburgerButtonTypeCloseButton
                                                                lineWidth:20
                                                               lineHeight:20/6
                                                              lineSpacing:2
                                                               lineCenter:CGPointMake(25, 25)
                                                                    color:[UIColor whiteColor]];
    [_buttonHamburgerCloseSmall setCenter:CGPointMake(_buttonHamburgerClose.center.x + 100, 120)];
    [_buttonHamburgerCloseSmall setBackgroundColor:[UIColor blackColor]];
    [_buttonHamburgerCloseSmall addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_buttonHamburgerCloseSmall];
    
    _buttonHamburgerBackSmall = [[LBHamburgerButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)
                                                       withHamburgerType:LBHamburgerButtonTypeBackButton
                                                               lineWidth:20
                                                              lineHeight:20/6
                                                             lineSpacing:2
                                                              lineCenter:CGPointMake(25, 25)
                                                                   color:[UIColor whiteColor]];
    [_buttonHamburgerBackSmall setCenter:CGPointMake(_buttonHamburgerCloseSmall.center.x, _buttonHamburgerCloseSmall.center.y + 120)];
    [_buttonHamburgerBackSmall setBackgroundColor:[UIColor blackColor]];
    [_buttonHamburgerBackSmall addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_buttonHamburgerBackSmall];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPressed:(id)sender {
    LBHamburgerButton* btn = (LBHamburgerButton*)sender;
    [btn switchState];
}

@end
