//
//  StorifyService.h
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StorifyStory;

typedef void (^StoriesResultsBlock)(NSArray *stories);
typedef void (^StoryResultsBlock)(StorifyStory *story);

@interface StorifyService : NSObject {
    
}

@property (nonatomic, retain) NSOperationQueue *operationQueue;

- (void)findStoriesByTopic:(NSString *)topic andInvokeBlock:(StoriesResultsBlock)block;
- (void)getStoryDetailsForStory:(StorifyStory *)story andInvokeBlock:(StoryResultsBlock)block;

@end
