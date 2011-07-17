//
//  StoriesListViewController.h
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoryViewController;
@class StorifyService;

@interface StoriesListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    StorifyService *storifyService;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, copy) NSArray *stories;
@property(nonatomic, retain) StoryViewController *storyViewController;

@end
