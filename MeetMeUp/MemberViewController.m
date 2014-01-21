//
//  MemberViewController.m
//  MeetMeUp
//
//  Created by Kagan Riedel on 1/20/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "MemberViewController.h"

@interface MemberViewController ()
{
    NSArray *memberInfo;
    __weak IBOutlet UITextView *memberTableView;
}

@end

@implementation MemberViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *idString = [NSString stringWithFormat:@"https://api.meetup.com/2/profiles?&sign=true&member_id=%@&page=20&key=4b52491924a2a61351604627265a78", _memberID];
    NSURL *url = [NSURL URLWithString:idString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         memberInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError][@"results"];
         [self didReturnJSONResults];
     }];
}

-(void) didReturnJSONResults
{
    NSDictionary *memberName = memberInfo[0];
    self.navigationItem.title = memberName[@"name"];
}



@end
