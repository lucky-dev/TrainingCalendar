//
//  Utils.m
//  TrainingCalendar
//
//  Created by user on 20.07.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "Utils.h"
#import "Constants.h"

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

+ (NSDate*) getDefaultDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSInteger comps = (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
    
    NSDateComponents* dateComponents = [calendar components:comps fromDate: [NSDate date]];
    [dateComponents setYear: 1970];
    [dateComponents setMonth: 1];
    [dateComponents setDay: 1];
    
    NSDate* result = [calendar dateFromComponents: dateComponents];
    
    return result;
}

+ (NSDate*) getNowDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSInteger comps = (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
    
    NSDateComponents* dateComponents = [calendar components:comps fromDate: [NSDate date]];
    
    NSDate* result = [calendar dateFromComponents: dateComponents];
    
    return result;
}


@end
