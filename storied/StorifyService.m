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
- (void)findStoriesByTopic:(NSString *)topic andInvokeBlock:(StoryResultsBlock)block {
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
        }
    }];
    [self.operationQueue addOperation:request];
}

//GET storify.com/:username.:format[?callback=:callback]
//GET storify.com/:authorUsername/title.:format[?callback=:callback]
//POST storify.com/story/new
//POST :storyURL/elements/add
//POST storify.com/:authorUsername/:title/publish
//POST storify.com/:authorUsername/:title/remove

@end