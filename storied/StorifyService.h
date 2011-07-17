//
//  StorifyService.h
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^StoryResultsBlock)(NSArray *stories);

@interface StorifyService : NSObject {
    
}

@property (nonatomic, retain) NSOperationQueue *operationQueue;

- (void)findStoriesByTopic:(NSString *)topic andInvokeBlock:(StoryResultsBlock)block;

@end
