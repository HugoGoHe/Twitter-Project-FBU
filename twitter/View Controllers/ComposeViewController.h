//
//  ComposeViewController.h
//  twitter
//
//  Created by Hugo Gomez Herrera on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

-(void) didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *TweetTextView;
@property (nonatomic,weak) id<ComposeViewControllerDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
