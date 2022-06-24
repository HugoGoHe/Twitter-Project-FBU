//
//  DetailsPageViewController.h
//  twitter
//
//  Created by Hugo Gomez Herrera on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsPageViewController : UIViewController

@property(strong, nonatomic) Tweet *selectedTweet;

@end

NS_ASSUME_NONNULL_END
