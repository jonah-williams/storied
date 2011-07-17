//
//  StorifyStory.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "StorifyStory.h"
#import "StorifyUser.h"

@implementation StorifyStory


@synthesize permalink = permalink_;
@synthesize published_at = published_at_;
@synthesize author = author_;
@synthesize editors = editors_;
@synthesize shorturl = shorturl_;
@synthesize title = title_;
@synthesize description = description_;
@synthesize thumbnail = thumbnail_;
@synthesize topics = topics_;
@synthesize elements = elements_;

- (id)initWithJSONDictionary:(NSDictionary *)jsonRepresentation {
    self = [super init];
    if (self) {
        self.permalink = [NSURL URLWithString:[jsonRepresentation objectForKey:@"permalink"]];
        self.published_at = [NSDate dateWithTimeIntervalSince1970:[[jsonRepresentation objectForKey:@"permalink"] doubleValue]];
        self.author = [[[StorifyUser alloc] initWithJSONDictionary:[jsonRepresentation objectForKey:@"author"]] autorelease];
        self.shorturl = [NSURL URLWithString:[jsonRepresentation objectForKey:@"shorturl"]];
        self.title = [jsonRepresentation objectForKey:@"title"];
        self.description = [jsonRepresentation objectForKey:@"description"];
        self.thumbnail = [NSURL URLWithString:[jsonRepresentation objectForKey:@"thumbnail"]];
        self.topics = [jsonRepresentation objectForKey:@"topics"];
    }
    return self;

}

- (void)dealloc {
    [permalink_ release], permalink_ = nil;
    [published_at_ release], published_at_ = nil;
    [author_ release], author_ = nil;
    [editors_ release], editors_ = nil;
    [shorturl_ release], shorturl_ = nil;
    [title_ release], title_ = nil;
    [description_ release], description_ = nil;
    [thumbnail_ release], thumbnail_ = nil;
    [topics_ release], topics_ = nil;
    [elements_ release], elements_ = nil;
    [super dealloc];
}

@end
