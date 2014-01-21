//
//  CommentsViewController.m
//  MeetMeUp
//
//  Created by Kagan Riedel on 1/20/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "CommentsViewController.h"

@interface CommentsViewController () <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *commentsTableView;
    NSArray *comments;
}

@end

@implementation CommentsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/event_comments?&sign=true&event_id=150355512&page=20&key=4b52491924a2a61351604627265a78"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         comments = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError][@"results"];
         [commentsTableView reloadData];
     }];

}




#pragma mark UITableViewDelegate&DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsCellID"];
    NSDictionary *comment = comments[indexPath.row];
  
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    
    CFTimeInterval seconds = [[comment valueForKey:@"time"] doubleValue] / 1000.0;
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@", comment[@"member_name"], [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970: seconds] ]];
    cell.detailTextLabel.text = comment[@"comment"];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return comments.count;
}


@end
