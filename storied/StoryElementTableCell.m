//
//  StoryElementTableCell.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "StoryElementTableCell.h"
#import "StorifyElement.h"
#import "StorifyUser.h"

@implementation StoryElementTableCell

@synthesize titleLabel = titleLabel_;
@synthesize descriptionLabel = descriptionLabel_;
@synthesize authorLabel = authorLabel_;
@synthesize createdAtLabel = createdAtLabel_;
@synthesize imageView = imageView_;
@synthesize element = element_;

- (void)dealloc
{
    [titleLabel_ release], titleLabel_ = nil;
    [descriptionLabel_ release], descriptionLabel_ = nil;
    [authorLabel_ release], authorLabel_ = nil;
    [createdAtLabel_ release], createdAtLabel_ = nil;
    [imageView_ release], imageView_ = nil;
    [element_ release], element_ = nil;
    [super dealloc];
}

- (void)setElement:(StorifyElement *)element {
    if (element_ != element) {
        [element_ release];
        element_ = [element retain];
        self.titleLabel.text = element_.title;
        self.descriptionLabel.text = element_.description;
        StorifyUser *author = element_.author;
        self.authorLabel.text = author.name;
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateStyle:NSDateFormatterFullStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        self.createdAtLabel.text = [dateFormatter stringFromDate:element_.created_at];
    }
}

@end
