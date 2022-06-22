//
//  User.m
//  twitter
//
//  Created by Hugo Gomez Herrera on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

//Initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        
    // Initialize any other properties
    }
    return self;
}

@end
