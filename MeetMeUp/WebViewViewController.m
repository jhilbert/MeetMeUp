//
//  WebViewViewController.m
//  MeetMeUp
//
//  Created by Kagan Riedel on 1/20/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController () <UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *myWebView;
    __weak IBOutlet UIActivityIndicatorView *activitySpinner;
    
    
}

@end

@implementation WebViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSURL *url = _link;
    NSURLRequest *request = [NSURLRequest requestWithURL:_link];
    [myWebView loadRequest:request];
}






- (IBAction)onBackButtonPressed:(id)sender
{
    [myWebView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    [myWebView goForward];
}

@end
