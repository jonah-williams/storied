//
//  StoryViewController.h
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StorifyStory;
@class StoryHeaderView;

@interface StoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, retain) StorifyStory *story;
@property(nonatomic, retain) IBOutlet StoryHeaderView *headerView;

@end
