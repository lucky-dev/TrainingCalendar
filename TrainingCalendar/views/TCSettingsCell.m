//
//  TCSettingsCell.m
//  TrainingCalendar
//
//  Created by user on 23.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "TCSettingsCell.h"

@implementation TCSettingsCell

- (id) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void) setSelected: (BOOL)selected animated: (BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) dealloc
{
    [_nameDay release];
    [_switchDay release];
    [super dealloc];
}
@end
