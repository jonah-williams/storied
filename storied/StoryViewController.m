//
//  StoryViewController.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "StoryViewController.h"
#import "StorifyStory.h"
#import "StoryHeaderView.h"
#import "StoryElementTableCell.h"
#import "StorifyService.h"

@implementation StoryViewController

@synthesize tableView = tableView_;
@synthesize story = story_;
@synthesize headerView = headerView_;
@synthesize storyElementCellNib = storyElementCellNib_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        storifyService = [[StorifyService alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [tableView_ release], tableView_ = nil;
    [story_ release], story_ = nil;
    [headerView_ release], headerView_ = nil;
    [storyElementCellNib_ release], storyElementCellNib_ = nil;
    [super dealloc];
}

- (void)setStory:(StorifyStory *)story {
    if (story != story_) {
        [storifyService.operationQueue cancelAllOperations];
        [story_ release];
        story_ = [story retain];
        self.title = story_.title;
        self.headerView.story = story_;
        [self.tableView reloadData];
        [storifyService getStoryDetailsForStory:story_ andInvokeBlock:^(StorifyStory *updatedStory) {
            story_.elements = updatedStory.elements;
            [self.tableView reloadData];
        }];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storyElementCellNib = [UINib nibWithNibName:@"StoryElementCell" bundle:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tableView = nil;
    self.headerView = nil;
    self.storyElementCellNib = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = nil;
    if (self.story) {
        headerView = self.headerView;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.story ? self.headerView.bounds.size.height : 0;
}

#pragma mark - UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.story.elements count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryElementTableCell *cell = (StoryElementTableCell *)[tableView dequeueReusableCellWithIdentifier:@"StoryElementTableCell"];
    if (cell == nil) {
        cell = [[self.storyElementCellNib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    }
    cell.element = [self.story.elements objectAtIndex:indexPath.row];
    return cell;
}


@end
