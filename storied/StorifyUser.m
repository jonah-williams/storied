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
        NSMutableDictionary *jsonDictionary = [NSMutableDictionary dictionary];
        NSArray *jsonDictionaryKeys = [jsonRepresentation allKeys];
        for (id key in jsonDictionaryKeys) {
            if ([NSNull null] != [jsonRepresentation objectForKey:key]) {
                [jsonDictionary setObject:[jsonRepresentation objectForKey:key] forKey:key];
            }
        }
        
        self.username = [jsonDictionary objectForKey:@"username"];
        self.name = [jsonDictionary objectForKey:@"name"];
        self.avatar = [NSURL URLWithString:[jsonDictionary objectForKey:@"avatar"]];
        self.description = [jsonDictionary objectForKey:@"description"];
        self.location = [jsonDictionary objectForKey:@"location"];
        self.website = [NSURL URLWithString:[jsonDictionary objectForKey:@"website"]];
        self.permalink = [NSURL URLWithString:[jsonDictionary objectForKey:@"permalink"]];
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

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (self.username != nil) {    [dictionary setObject:self.username forKey:@"username"];}
    if (self.name != nil) {    [dictionary setObject:self.name forKey:@"name"];}
    if (self.avatar != nil) {    [dictionary setObject:[self.avatar absoluteString] forKey:@"avatar"];}
    if (self.description != nil) {    [dictionary setObject:self.description forKey:@"description"];}
    if (self.location != nil) {    [dictionary setObject:self.location forKey:@"location"];}
    if (self.website != nil) {    [dictionary setObject:[self.website absoluteString] forKey:@"website"];}
    if (self.permalink != nil) {    [dictionary setObject:[self.permalink absoluteString] forKey:@"permalink"];}
    return dictionary;
}

@end
