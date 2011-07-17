//
//  StorifyElement.h
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StorifyUser;

@interface StorifyElement : NSObject {
    
}

@property(nonatomic, retain) StorifyUser *curator;
@property(nonatomic, copy) NSString *source;
@property(nonatomic, copy) NSURL *image;
@property(nonatomic, copy) NSString *elementClass;
@property(nonatomic, copy) NSURL *permalink;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSURL *thumbnail;
@property(nonatomic, copy) NSURL *favicon;
@property(nonatomic, copy) StorifyUser *author;
@property(nonatomic, copy) NSDate *created_at;
@property(nonatomic, copy) NSDate *added_at;
@property(nonatomic, copy) NSString *oembed;

@end
