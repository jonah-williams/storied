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
