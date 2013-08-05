//
//  SettingDayModel.m
//  TrainingCalendar
//
//  Created by user on 23.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "SettingDayModel.h"

@implementation SettingDayModel

- (SettingDayModel*) initWithName: (NSString*)nameDay code: (NSInteger)codeDay andState: (BOOL)state
{
    self = [super init];
    
    if (self)
    {
        self.nameDay = nameDay;
        self.codeDay = codeDay;
        self.status = state;
    }
    
    return self;
}

- (void) dealloc
{
    NSLog(@"dealloc %@", self.nameDay);
    
    self.nameDay = nil;
    
    [super dealloc];
}

@end
