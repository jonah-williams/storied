//
//  StorifyUser.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "StorifyUser.h"


@implementation StorifyUser

@synthesize username = username_;
@synthesize name = name_;
@synthesize avatar = avatar_;
@synthesize description = description_;
@synthesize location = location_;
@synthesize website = website_;
@synthesize permalink = permalink_;

- (id)initWithJSONDictionary:(NSDictionary *)jsonRepresentation {
    self = [super init];
    if (self) {
        self.username = [jsonRepresentation objectForKey:@"username"];
        self.name = [jsonRepresentation objectForKey:@"name"];
        self.avatar = [NSURL URLWithString:[jsonRepresentation objectForKey:@"avatar"]];
        self.description = [jsonRepresentation objectForKey:@"description"];
        self.location = [jsonRepresentation objectForKey:@"location"];
        self.website = [NSURL URLWithString:[jsonRepresentation objectForKey:@"website"]];
        self.permalink = [NSURL URLWithString:[jsonRepresentation objectForKey:@"permalink"]];
    }
    return self;
}

- (void)dealloc {
    [username_ release], username_ = nil;
    [name_ release], name_ = nil;
    [avatar_ release], avatar_ = nil;
    [description_ release], description_ = nil;
    [location_ release], location_ = nil;
    [website_ release], website_ = nil;
    [permalink_ release], permalink_ = nil;
    [super dealloc];
}

@end
