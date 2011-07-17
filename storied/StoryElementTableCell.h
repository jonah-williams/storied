//
//  StoryElementTableCell.h
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StorifyElement;

@interface StoryElementTableCell : UITableViewCell {
    
}

@property(nonatomic, retain) IBOutlet UILabel *titleLabel;
@property(nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property(nonatomic, retain) IBOutlet UILabel *authorLabel;
@property(nonatomic, retain) IBOutlet UILabel *createdAtLabel;
@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) StorifyElement *element;

@end
