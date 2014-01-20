//
//  ViewController.m
//  MeetMeUp
//
//  Created by Kagan Riedel on 1/20/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *meetUps;
    
    __weak IBOutlet UITableView *meetUpTableView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=235b643553866353e4c64601c4b142c"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
       meetUps = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError][@"results"];
        [meetUpTableView reloadData];
    }];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *vc = segue.destinationViewController;
    NSIndexPath *indexPath = [meetUpTableView indexPathForSelectedRow];
    vc.meetUp = meetUps[indexPath.row];
}



#pragma mark UITableViewDelegate&DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return meetUps.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetUpCell"];
    NSDictionary *meetUp = [meetUps objectAtIndex:indexPath.row];
    
    cell.textLabel.text = meetUp[@"name"];
    cell.detailTextLabel.text = meetUp[@"venue"][@"address_1"];
    
    return cell;
    
}

@end
