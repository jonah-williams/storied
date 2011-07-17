//
//  StorifyUser.h
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StorifyUser : NSObject {
    
}

@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSURL *avatar;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSString *location;
@property(nonatomic, copy) NSURL *website;
@property(nonatomic, copy) NSURL *permalink;

- (id)initWithJSONDictionary:(NSDictionary *)jsonRepresentation;
- (NSDictionary *)dictionaryRepresentation;

@end
