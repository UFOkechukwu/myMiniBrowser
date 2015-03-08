//
//  ViewController.m
//  MiniBrowser
//
//  Created by Ugochukwu Okechukwu on 2/25/15.
//  Copyright (c) 2015 U.F.Okechukwu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// Define iPad
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
//--------------------------------------


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set web View
    
    if ( IDIOM == IPAD ) {
        /* iPad. */
        self.miniWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0.0, 47.0, self.view.frame.size.width, self.view.frame.size.height - 49)];
    } else {
        /* iPhone or iPod touch. */
        self.miniWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0.0, 47.0, 320.0, 525.0)];
    }

    [_miniWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    _miniWebView.navigationDelegate = self;
    
    [self.view addSubview:self.miniWebView];
    
    [self.miniWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)goBtn:(id)sender {
    [_addressBar resignFirstResponder];

    // Minor Setup
    if ([_addressBar.text rangeOfString:@"http://"].location == NSNotFound) {
        _addressBar.text = [@"http://" stringByAppendingString:_addressBar.text];
        [self loadWebViewAddress];
    } else {
        [self loadWebViewAddress];
    }


}

- (IBAction)goFowardBtn:(id)sender {
    // url go foward
    [_miniWebView goForward];
}

- (IBAction)goBackwardBtn:(id)sender {
    // url go backward
    [_miniWebView goBack];
}

- (void)loadWebViewAddress{
    
    // loads web link....
    NSURL *url = [NSURL URLWithString:_addressBar.text];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [_miniWebView loadRequest:requestObj];
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == _miniWebView) {
        
        // Progress bar estimation....
        [self.progressBar setProgress:_miniWebView.estimatedProgress animated:YES];
        
        if(_miniWebView.estimatedProgress >= 1.0) {
            _addressBar.text = [_miniWebView.URL absoluteString];
            [self performSelector:@selector(clearProgressBar:) withObject:self afterDelay:1.0];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)clearProgressBar:(id)sender{
    [self.progressBar setProgress:0 animated:NO];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    // Loading error display...
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                        message:@"Invalid URL"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
    [alertView show];
    
}



@end
