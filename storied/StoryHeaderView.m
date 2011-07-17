//
//  StoryHeaderView.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "StoryHeaderView.h"
#import "StorifyStory.h"
#import "StorifyUser.h"

@implementation StoryHeaderView

@synthesize story = story_;
@synthesize titleLabel = titleLabel_;
@synthesize descriptionLabel = descriptionLabel_;
@synthesize authorLabel = authorLabel_;
@synthesize publishedAtLabel = publishedAtLabel_;

- (void)dealloc
{
    [story_ release], story_ = nil;
    [titleLabel_ release], titleLabel_ = nil;
    [descriptionLabel_ release], descriptionLabel_ = nil;
    [authorLabel_ release], authorLabel_ = nil;
    [publishedAtLabel_ release], publishedAtLabel_ = nil;
    [super dealloc];
}

- (void)setStory:(StorifyStory *)story {
    if (story_ != story) {
        [story_ release];
        story_ = [story retain];
        self.titleLabel.text = story_.title;
        self.descriptionLabel.text = story_.description;
        StorifyUser *author = story_.author;
        self.authorLabel.text = author.name;
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateStyle:NSDateFormatterFullStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        self.publishedAtLabel.text = [dateFormatter stringFromDate:story_.published_at];
    }
}

@end
