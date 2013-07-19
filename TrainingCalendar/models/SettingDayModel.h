//
//  SettingDayModel.h
//  TrainingCalendar
//
//  Created by user on 23.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingDayModel : NSObject

@property(retain, nonatomic) NSString *nameDay;
@property(assign, nonatomic) BOOL status;

-(SettingDayModel *)initWithName:(NSString *) nameDay andState:(BOOL)state;

@end
