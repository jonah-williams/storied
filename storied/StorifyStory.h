//
//  StorifyStory.h
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StorifyUser;

@interface StorifyStory : NSObject {
    
}

@property(nonatomic, copy) NSURL *permalink;
@property(nonatomic, copy) NSDate *published_at;
@property(nonatomic, retain) StorifyUser *author;
@property(nonatomic, copy) NSArray *editors;
@property(nonatomic, copy) NSURL *shorturl;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSURL *thumbnail;
@property(nonatomic, copy) NSArray *topics;
@property(nonatomic, copy) NSArray *elements;

- (id)initWithJSONDictionary:(NSDictionary *)jsonRepresentation;

@end
