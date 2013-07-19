//
//  SettingDayModel.m
//  TrainingCalendar
//
//  Created by user on 23.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "SettingDayModel.h"

@implementation SettingDayModel

- (SettingDayModel *)initWithName:(NSString *) nameDay andState:(BOOL)state
{
    self = [super init];
    
    if (self)
    {
        self.nameDay = nameDay;
        self.status = state;
    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"dealloc %@", self.nameDay);
    
    [super dealloc];
}

@end
