//
//  Utils.m
//  TrainingCalendar
//
//  Created by user on 20.07.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString*) getNameOfCurrentDay
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"EEEE"];
    
    NSString* dayOfWeek = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter release];
    
    return dayOfWeek;
}

+ (NSInteger) getCodeOfCurrentDay
{    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents* todayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    
    [gregorian release];
    
    return [todayComponents weekday];
}

@end
