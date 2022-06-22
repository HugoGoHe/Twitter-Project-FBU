//
//  User.h
//  twitter
//
//  Created by Hugo Gomez Herrera on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

//There are many properties for a given user, however we’ll start with the minimum needed for displaying a User (name, screen name and profile picture).
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;

//Aditional properties here

//Initializer
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
