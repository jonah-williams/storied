//
//  storiedAppDelegate.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "storiedAppDelegate.h"
#import "StoriesListViewController.h"
#import "StoryViewController.h"

@implementation storiedAppDelegate

@synthesize window=window_;
@synthesize splitViewController = splitViewController_;
@synthesize storiesListViewController = storiesListViewController_;
@synthesize storyViewController = storyViewController_;

- (void)dealloc
{
    [window_ release], window_ = nil;
    [splitViewController_ release], splitViewController_ = nil;
    [storiesListViewController_ release], storiesListViewController_ = nil;
    [storyViewController_ release], storyViewController_ = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.splitViewController = [[[UISplitViewController alloc] init] autorelease];
    self.storiesListViewController = [[[StoriesListViewController alloc] init] autorelease];
    self.storyViewController = [[[StoryViewController alloc] init] autorelease];
    
    UINavigationController *listNavController = [[[UINavigationController alloc] initWithRootViewController:self.storiesListViewController] autorelease];
    UINavigationController *detailsNavController = [[[UINavigationController alloc] initWithRootViewController:self.storyViewController] autorelease];
    self.splitViewController.viewControllers = [NSArray arrayWithObjects:listNavController, detailsNavController, nil];
    
    self.window.rootViewController = self.splitViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
