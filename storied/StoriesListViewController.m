//
//  StoriesListViewController.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "StoriesListViewController.h"
#import "StoryViewController.h"
#import "StorifyStory.h"
#import "StorifyService.h"

@implementation StoriesListViewController

@synthesize tableView = tableView_;
@synthesize stories = stories_;
@synthesize storyViewController = storyViewController_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Stories";
        storifyService = [[StorifyService alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [tableView_ release], tableView_ = nil;
    [stories_ release], stories_ = nil;
    [storyViewController_ release], storyViewController_ = nil;
    [storifyService release], storifyService = nil;
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StorifyStory *story = [self.stories objectAtIndex:indexPath.row];
    self.storyViewController.story = story;
}

#pragma mark - UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.stories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil] autorelease];
    StorifyStory *story = [self.stories objectAtIndex:indexPath.row];
    cell.textLabel.text = story.title;
    cell.detailTextLabel.text = story.description;
    return cell;
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"searching for %@", searchBar.text);
    [storifyService findStoriesByTopic:searchBar.text andInvokeBlock:^(NSArray *stories) {
        self.stories = stories;
        [self.tableView reloadData];
    }];
    [searchBar resignFirstResponder];
}

@end
