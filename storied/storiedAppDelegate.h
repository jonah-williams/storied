//
//  storiedAppDelegate.h
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoriesListViewController;

@class StoryViewController;

@interface storiedAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet StoriesListViewController *storiesListViewController;
@property (nonatomic, retain) IBOutlet StoryViewController *storyViewController;

@end
