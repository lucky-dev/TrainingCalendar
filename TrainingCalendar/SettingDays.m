//
//  SettingDays.m
//  TrainingCalendar
//
//  Created by user on 30.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "SettingDays.h"
#import "SettingDayModel.h"

const NSString* kFileDays = @"days_week.plist";

static SettingDays* sharedSettingDays = nil;

@interface SettingDays ()

- (NSMutableArray *)getEmptyArrayDays;
- (NSString *)dataFilePath;

@end

@implementation SettingDays

+ (SettingDays *)sharedManager
{    
    if (sharedSettingDays == nil)
    {
        sharedSettingDays = [[super allocWithZone:NULL] init];
    }

    return sharedSettingDays;
}

- (NSArray *)getDaysOnlyEnabled:(BOOL) flag
{
    NSString *filePath = [self dataFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        
        for (NSDictionary *dict in array)
        {
            NSString *nameDay = [dict valueForKey:@"name_day"];
            BOOL status = [[dict valueForKey:@"status"] boolValue];
            
            if (((status) && (flag)) || (!flag))
            {
                SettingDayModel *settingDay = [[SettingDayModel alloc] initWithName:nameDay andState:status];
            
                [result addObject:settingDay];
            
                [settingDay release];
            }
        }
        
        [array release];
    }
    else
    {
        return [self getEmptyArrayDays];
    }

    return result;
}

- (void)saveDays:(NSArray *) arrayDays
{
    NSString *filePath = [self dataFilePath];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (SettingDayModel* item in arrayDays)
    {
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:item.nameDay, @"name_day",
                                                                          [NSNumber numberWithBool:item.status], @"status",
                                                                           nil];
        
        [result addObject:dict];
        
        [dict release];
    }
    
    [result writeToFile:filePath atomically:YES];
    
    [result release];
}

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:kFileDays];
}

- (NSMutableArray *)getEmptyArrayDays
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSArray *days = [[NSArray alloc] initWithObjects: @"Monday",
                                                      @"Tuesday",
                                                      @"Wednesday",
                                                      @"Thursday",
                                                      @"Friday",
                                                      @"Saturday",
                                                      @"Sunday",
                                                      nil];
    
    for (NSString* item in days)
    {
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:item, @"name_day",
                              FALSE, @"status",
                              nil];
        
        [result addObject:dict];
        
        [dict release];
    }
    
    return result;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedManager] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (void)release
{
}

- (id)autorelease
{
    return self;
}

@end
