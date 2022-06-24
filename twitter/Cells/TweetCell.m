//
//  TweetCell.m
//  twitter
//
//  Created by Hugo Gomez Herrera on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//
#import "APIManager.h"
#import "TweetCell.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.profileView.layer.cornerRadius = self.profileView.frame.size.width / 2;
    self.profileView.clipsToBounds = YES;
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapFavorite:(id)sender {
    // Update the local tweet model
    if (self.tweet.favorited){
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
            
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
            [self refreshData];
        }];
        
    } else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
                
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
            [self refreshData];
        }];
    }

}
- (IBAction)didTapRetweet:(id)sender {
        if (self.tweet.retweeted){
            self.tweet.retweeted = NO;
            self.tweet.retweetCount -= 1;
            
            // Send a POST request to the POST favorites/create endpoint
            [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if(error){
                     NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
                }
                else{
                    NSLog(@"Successfully unretweeting the following Tweet: %@", tweet.text);
                }
                [self refreshData];
            }];
    } else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
            
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeting the following Tweet: %@", tweet.text);
            }
            [self refreshData];
        }];
        
    }
    
}

-(void)refreshData {
    
    if(self.tweet.favorited == NO){
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    } else{
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    
    if(self.tweet.retweeted == NO){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    } else{
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }

    self.favoriteCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
    
    self.retweetCountLabel.text = [@(self.tweet.retweetCount) stringValue];
}

@end
