//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "Tweet.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"


@interface TimelineViewController () <UITableViewDataSource,UITableViewDelegate>

@property NSMutableArray *arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error){
        
        
        if (tweets) {
           // self.arrayOfTweets = tweets;
          //
            
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
                self.arrayOfTweets = (NSMutableArray *)tweets;
            }
            NSLog(@"%@", self.arrayOfTweets);
            [self.tableView reloadData];

        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
        
    }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapLogout:(id)sender {
    //Switching screen to loginViewController
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    //Clearing out the access tokens
    [[APIManager shared] logout];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //returning the number of tweets
    return self.arrayOfTweets.count;
}

- (nonnull UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    
    cell.tweet = tweet;
    cell.nameLabel.text = tweet.user.name;
    cell.screenNameLabel.text = tweet.user.screenName;
    cell.createdAtLabel.text = tweet.createdAtString;
    cell.textTweetLabel.text = tweet.text;
    
    cell.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];

    cell.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
   // NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    [cell.profileView setImageWithURL:url];
    
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
