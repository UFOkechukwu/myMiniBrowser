//
//  ViewController.h
//  MiniBrowser
//
//  Created by Ugochukwu Okechukwu on 2/25/15.
//  Copyright (c) 2015 U.F.Okechukwu. All rights reserved.
//

#import <UIKit/UIKit.h>
@import WebKit;

@interface ViewController : UIViewController<WKNavigationDelegate>

@property (strong, nonatomic) IBOutlet WKWebView *miniWebView;

@property (strong, nonatomic) IBOutlet UITextField *addressBar;

@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;

- (IBAction)goBtn:(id)sender;

- (IBAction)goFowardBtn:(id)sender;

- (IBAction)goBackwardBtn:(id)sender;


@end

