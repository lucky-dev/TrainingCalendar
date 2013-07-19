//
//  SettingDays.h
//  TrainingCalendar
//
//  Created by user on 30.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingDays : NSObject

+ (SettingDays *)sharedManager;
- (NSArray *)getDaysOnlyEnabled:(BOOL) flag;
- (void)saveDays:(NSArray *) array;

@end
