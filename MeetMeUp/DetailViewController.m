//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Kagan Riedel on 1/20/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewViewController.h"

@interface DetailViewController () 
{
    __weak IBOutlet UILabel *rsvpLabel;
    __weak IBOutlet UILabel *hostLabel;
    __weak IBOutlet UIWebView *descriptionWebView; //using a webView here to properly display the HTML formatting
}

@end

@implementation DetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = _meetUp[@"name"];
    rsvpLabel.text = [NSString stringWithFormat:@"%@",_meetUp[@"yes_rsvp_count"]];
    hostLabel.text = _meetUp[@"group"][@"name"];
    [descriptionWebView loadHTMLString:_meetUp[@"description"] baseURL:nil];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewViewController *vc = segue.destinationViewController;
    vc.link =  [NSURL URLWithString: _meetUp[@"event_url"]];
}



@end
