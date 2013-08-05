//
//  SettingDayModel.h
//  TrainingCalendar
//
//  Created by user on 23.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingDayModel : NSObject

@property (retain, nonatomic) NSString* nameDay;
@property (assign, nonatomic) NSInteger codeDay;
@property (assign, nonatomic) BOOL status;

- (SettingDayModel*) initWithName: (NSString*)nameDay code: (NSInteger)codeDay andState: (BOOL)state;

@end
