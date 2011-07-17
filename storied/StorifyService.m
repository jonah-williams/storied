//
//  StorifyService.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "StorifyService.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "BlocksKit/BlocksKit.h"
#import "StorifyStory.h"
#import "StorifyUser.h"

@implementation StorifyService

@synthesize operationQueue = operationQueue_;

- (id)init {
    self = [super init];
    if (self) {
        operationQueue_ = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)dealloc {
    [operationQueue_ release], operationQueue_ = nil;
    [super dealloc];
}

//GET storify.com/topics/:hashtag.json[?callback=:callback]
- (void)findStoriesByTopic:(NSString *)topic andInvokeBlock:(StoriesResultsBlock)block {
    NSString *urlString = [NSString stringWithFormat:@"http://storify.com/topics/%@.json", [topic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setFailedBlock:^(void) {
        NSLog(@"request for %@ failed with response: %@ | %@", urlString, request.responseStatusMessage, [request responseString]);
    }];
    [request setCompletionBlock:^(void) {
        NSLog(@"request for %@ succeeded with response: %@ | %@", urlString, request.responseStatusMessage, [request responseString]);
        if (request.responseStatusCode == 200) {
            NSDictionary *responseDictionary = [[request responseString] objectFromJSONString];
            NSArray *jsonStories = [responseDictionary objectForKey:@"stories"];
            NSArray *stories = [jsonStories map:^id(id obj) {
                return [[[StorifyStory alloc] initWithJSONDictionary:obj] autorelease];
            }];
            block(stories);
        }
    }];
    [self.operationQueue addOperation:request];
}

//GET storify.com/:authorUsername/title.:format[?callback=:callback]
- (void)getStoryDetailsForStory:(StorifyStory *)story andInvokeBlock:(StoryResultsBlock)block {
    NSString *urlString = [NSString stringWithFormat:@"%@.json", story.permalink];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setFailedBlock:^(void) {
        NSLog(@"request for %@ failed with response: %@ | %@", urlString, request.responseStatusMessage, [request responseString]);
    }];
    [request setCompletionBlock:^(void) {
        NSLog(@"request for %@ succeeded with response: %@ | %@", urlString, request.responseStatusMessage, [request responseString]);
        if (request.responseStatusCode == 200) {
            NSDictionary *responseDictionary = [[request responseString] objectFromJSONString];
            StorifyStory *updatedStory = [[[StorifyStory alloc] initWithJSONDictionary:responseDictionary] autorelease];
            block(updatedStory);
        }
    }];
    [self.operationQueue addOperation:request];
}

//GET storify.com/:username.:format[?callback=:callback]
//POST storify.com/story/new
//POST :storyURL/elements/add
//POST storify.com/:authorUsername/:title/publish
//POST storify.com/:authorUsername/:title/remove

@end
