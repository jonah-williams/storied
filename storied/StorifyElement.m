//
//  StorifyElement.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "StorifyElement.h"
#import "StorifyUser.h"

@implementation StorifyElement

@synthesize curator = curator_;
@synthesize source = source_;
@synthesize image = image_;
@synthesize elementClass = elementClass_;
@synthesize permalink = permalink_;
@synthesize title = title_;
@synthesize description = description_;
@synthesize thumbnail = thumbnail_;
@synthesize favicon = favicon_;
@synthesize author = author_;
@synthesize created_at = created_at_;
@synthesize added_at = added_at_;
@synthesize oembed = oembed_;

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
        
        self.source = [jsonDictionary objectForKey:@"source"];
//        self.image = [NSURL URLWithString:[[jsonRepresentation objectForKey:@"image"] objectForKey:@"href"]];
        self.elementClass = [jsonDictionary objectForKey:@"elementClass"];
        self.permalink = [NSURL URLWithString:[jsonDictionary objectForKey:@"permalink"]];
        self.title = [jsonDictionary objectForKey:@"title"];
        self.description = [jsonDictionary objectForKey:@"description"];
        self.thumbnail = [NSURL URLWithString:[jsonDictionary objectForKey:@"thumbnail"]];
        self.author = [[[StorifyUser alloc] initWithJSONDictionary:[jsonDictionary objectForKey:@"author"]] autorelease];
        self.created_at = [NSDate dateWithTimeIntervalSince1970:[[jsonDictionary objectForKey:@"created_at"] doubleValue]];
        self.added_at = [NSDate dateWithTimeIntervalSince1970:[[jsonDictionary objectForKey:@"added_at"] doubleValue]];
    }
    return self;
}

- (void)dealloc {
    [curator_ release], curator_ = nil;
    [source_ release], source_ = nil;
    [image_ release], image_ = nil;
    [elementClass_ release], elementClass_ = nil;
    [permalink_ release], permalink_ = nil;
    [title_ release], title_ = nil;
    [description_ release], description_ = nil;
    [thumbnail_ release], thumbnail_ = nil;
    [favicon_ release], favicon_ = nil;
    [author_ release], author_ = nil;
    [created_at_ release], created_at_ = nil;
    [added_at_ release], added_at_ = nil;
    [oembed_ release], oembed_ = nil;
    [super dealloc];
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (self.source != nil) {    [dictionary setObject:self.source forKey:@"source"];}
    if (self.elementClass != nil) {    [dictionary setObject:self.elementClass forKey:@"elementClass"];}
    if (self.permalink != nil) {    [dictionary setObject:[self.permalink absoluteString] forKey:@"permalink"];}
    if (self.title != nil) {    [dictionary setObject:self.title forKey:@"title"];}
    if (self.description != nil) {    [dictionary setObject:self.description forKey:@"description"];}
    if (self.thumbnail != nil) {    [dictionary setObject:[self.thumbnail absoluteString] forKey:@"thumbnail"];}
    [dictionary setObject:[self.author dictionaryRepresentation] forKey:@"author"];
    if (self.created_at != nil) {    [dictionary setObject:[[NSNumber numberWithDouble:[self.created_at timeIntervalSince1970]] stringValue] forKey:@"created_at"];}
    if (self.added_at != nil) {    [dictionary setObject:[[NSNumber numberWithDouble:[self.added_at timeIntervalSince1970]] stringValue] forKey:@"added_at"];}
    return dictionary;
}

@end
