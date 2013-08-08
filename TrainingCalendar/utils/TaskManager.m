//
//  TaskManager.m
//  TrainingCalendar
//
//  Created by user on 07.08.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "TaskManager.h"
#import "TaskModel.h"
#import "DBManager.h"
#import "Utils.h"
#import "Constants.h"

static const NSString* kFileTasks = @"tasks.plist";

static TaskManager* sharedTaskManager = nil;

@interface TaskManager ()

- (NSString*) dataFilePath;

@end

@implementation TaskManager

+ (TaskManager*) sharedManager
{
    if (sharedTaskManager == nil)
    {
        sharedTaskManager = [[super allocWithZone:NULL] init];
    }
    
    return sharedTaskManager;
}

- (TaskModel*) getTaskByCodeDay: (NSInteger)codeDay
{    
    NSString* filePath = [self dataFilePath];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSMutableArray* counters = [[NSMutableArray alloc] init];
    
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSArray* array = [[NSArray alloc] initWithContentsOfFile: filePath];
        
        for (NSDictionary* item in array)
        {
            NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [item valueForKey: @"counter"], @"counter",
                                                                                            [item valueForKey: @"date"], @"date",
                                                                                            nil];
            
            [counters addObject: dict];
            
            [dict release];
        }
        
        [array release];
    }
    else
    {
        for (int i = 0; i < 7; i++)
        {
            NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithInt: 0], @"counter",
                                                                                            [Utils getDefaultDate], @"date",
                                                                                            nil];
            
            [counters addObject: dict];
            
            [dict release];
        }
    }
    
    NSArray* tasks = [[DBManager sharedManager] getTasksByDay:[Utils getCodeOfCurrentDay]];
    NSInteger countTasks = [tasks count];

    NSMutableDictionary* currentCounter = counters[codeDay - 1];
    
    NSInteger counter = [[currentCounter objectForKey: @"counter"] intValue];
    
    TaskModel* result = nil;
    
    if (countTasks > 0)
    {
        NSDate* savedDate = [currentCounter objectForKey: @"date"];
        NSDate* nowDate = [Utils getNowDate];
        
        NSComparisonResult resultCompare = [savedDate compare: nowDate];
        
        switch (resultCompare) {
            case NSOrderedSame :
                
                if (counter > countTasks)
                {
                    counter = countTasks;
                }
                
                break;
                
            case NSOrderedAscending : // op1 < op2 (counter++)
            case NSOrderedDescending : // op1 > op2 (counter--)
                
                counter = (resultCompare == NSOrderedAscending ? counter + 1 : counter - 1);
                
                if (counter > countTasks)
                {
                    counter = 1;
                }
                
                if (counter < 1)
                {
                    counter = countTasks;
                }
                
                [currentCounter setValue: nowDate forKey: @"date"];
                
                break;
        }
        
        TaskModel* tmpTask = [tasks objectAtIndex: counter - 1];
        
        result = [[TaskModel alloc] initWithIdentifier: tmpTask.identifier
                                                 order: tmpTask.order
                                               codeDay: tmpTask.codeDay
                                                  name: tmpTask.nameTask
                                           description: tmpTask.descriptionTask
                                        andCountRepeat: tmpTask.countRepeat];
        
        [currentCounter setValue: [NSNumber numberWithInt: counter] forKey: @"counter"];
    }
    else
    {
        [currentCounter setValue: [NSNumber numberWithInt: 0] forKey: @"counter"];
        [currentCounter setValue: [Utils getDefaultDate] forKey: @"date"];
    }
    
    [counters writeToFile:filePath atomically:YES];
    
    [tasks release];
    [counters release];
    
    return result;
}

- (NSString*) dataFilePath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:kFileTasks];
}

+ (id) allocWithZone: (NSZone*)zone
{
    return [[self sharedManager] retain];
}

- (id) copyWithZone: (NSZone*)zone
{
    return self;
}

- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax;
}

- (void) release
{
}

- (id) autorelease
{
    return self;
}

@end
