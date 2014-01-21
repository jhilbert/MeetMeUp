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
    
    __weak IBOutlet UITextField *searchTextField;
    __weak IBOutlet UITableView *meetUpTableView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=4b52491924a2a61351604627265a78"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
       meetUps = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError][@"results"];
        [meetUpTableView reloadData];
    }];
    
}

- (IBAction)onSearchButtonPressed:(id)sender
{
    [self performJSONSearch];
    [meetUpTableView reloadData];
    [searchTextField resignFirstResponder];
    searchTextField.text = @"";
    
}


                              
- (void) performJSONSearch
{
    NSString *searchString = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=4b52491924a2a61351604627265a78", searchTextField.text];
    NSURL *url = [NSURL URLWithString:searchString];
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
    
    cell.imageView.image = [UIImage imageNamed:@"MeetUp.png"];
    
//    NSString *eventImageURL = [NSString stringWithFormat:@"https://api.meetup.com/2/photos?&sign=true&event_id=%@&page=20&key=235b643553866353e4c64601c4b142c", meetUp[@"id"]];
//    NSString *eventImageURL = @"https://api.meetup.com/2/photos?&sign=true&photo_id=314818762&page=20&key=235b643553866353e4c64601c4b142c";
//    
//    
//    NSLog(@"%@", meetUp[@"id"]);
//    
//    NSURL *url = [NSURL URLWithString:eventImageURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
//     {
//         NSArray *imageArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError][@"results"];
//         if (imageArray == nil) {
//             cell.imageView.image = [UIImage imageNamed:@"MeetUp.png"];
//         }else
//         {
//             NSString *photoID = imageArray[0][@"photo_link"];
//             cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoID]]];
//             [meetUpTableView reloadData];
//         }
//     }];
 
    
    return cell;
    
}

@end
