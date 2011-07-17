//
//  StoryHeaderView.h
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StorifyStory;

@interface StoryHeaderView : UIView {
    
}

@property(nonatomic, retain) StorifyStory *story;
@property(nonatomic, retain) IBOutlet UILabel *titleLabel;
@property(nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property(nonatomic, retain) IBOutlet UILabel *authorLabel;
@property(nonatomic, retain) IBOutlet UILabel *publishedAtLabel;

@end
