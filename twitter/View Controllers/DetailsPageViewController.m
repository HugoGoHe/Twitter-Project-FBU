//
//  DetailsPageViewController.m
//  twitter
//
//  Created by Hugo Gomez Herrera on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsPageViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "APIManager.h"

@interface DetailsPageViewController ()




@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *textTweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profileView.layer.cornerRadius = self.profileView.frame.size.width / 2;
    self.profileView.clipsToBounds = YES;
    
    NSString * URLString = self.selectedTweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.profileView setImageWithURL:url];
    
    self.nameLabel.text = self.selectedTweet.user.name;
    self.screenName.text = self.selectedTweet.user.screenName;
    self.textTweetLabel.text = self.selectedTweet.text;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.selectedTweet.retweetCount];
    self.createdAtLabel.text = self.selectedTweet.createdAtString;
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.selectedTweet.favoriteCount];
    
    
}
- (IBAction)didTapRetweet:(id)sender {
    if (self.selectedTweet.retweeted){
        self.selectedTweet.retweeted = NO;
        self.selectedTweet.retweetCount -= 1;
        [self refreshData];
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unretweet:self.selectedTweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeting the following Tweet: %@", tweet.text);
            }
        }];
} else{
    self.selectedTweet.retweeted = YES;
    self.selectedTweet.retweetCount += 1;
    [self refreshData];
    // Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] retweet:self.selectedTweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeting the following Tweet: %@", tweet.text);
        }
    }];
    
}

}
- (IBAction)didTapFavorite:(id)sender {
    // Update the local tweet model
    if (self.selectedTweet.favorited){
        self.selectedTweet.favorited = NO;
        self.selectedTweet.favoriteCount -= 1;
        [self refreshData];
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.selectedTweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
        
    } else{
        self.selectedTweet.favorited = YES;
        self.selectedTweet.favoriteCount += 1;
        [self refreshData];
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.selectedTweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}
- (IBAction)didTapReturn:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)refreshData{

    self.favoriteCountLabel.text = [@(self.selectedTweet.favoriteCount) stringValue];
    
    self.retweetCountLabel.text = [@(self.selectedTweet.retweetCount) stringValue];
}

@end
