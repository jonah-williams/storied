//
//  StorifyElement.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "StorifyElement.h"


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

@end
