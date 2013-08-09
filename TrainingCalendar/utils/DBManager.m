//
//  DBManager.m
//  TrainingCalendar
//
//  Created by user on 21.07.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "DBManager.h"
#import "SettingDayModel.h"
#import "TaskModel.h"

static const NSString* kPathDatabase = @"db_days.db";

static DBManager* sharedDbManager = nil;
static sqlite3* database = NULL;

@interface DBManager ()

- (NSString*) dataFilePath;
- (void) openDb;

@end

@implementation DBManager


+ (DBManager*) sharedManager
{
    if (sharedDbManager == nil)
    {
        sharedDbManager = [[super allocWithZone:NULL] init];
        [sharedDbManager openDb];
    }
    
    return sharedDbManager;
}

- (NSString*) dataFilePath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:kPathDatabase];
}

- (void) openDb
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK)
    {
        sqlite3_close(database);
        
        NSLog(@"Failed to open database");
        
        return;
    }
    
    const char* sqlCreateDatabase = "CREATE TABLE IF NOT EXISTS tasks "
                                    "(id INTEGER PRIMARY KEY AUTOINCREMENT, order_task INTEGER, code_day INTEGER, name TEXT, description TEXT, count_repeat INTEGER)";
    
    char* errorMsg = NULL;
    if (sqlite3_exec(database, sqlCreateDatabase, NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        
        NSLog(@"Failed to create table: %s", errorMsg);
        
        sharedDbManager = nil;
    }
}

- (NSArray*) getTasksByDay: (int)codeDay
{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    if (database != NULL)
    {
        NSString* query = [NSString stringWithFormat:@"SELECT * FROM tasks WHERE code_day=%d ORDER BY order_task ASC", codeDay];
    
        sqlite3_stmt* statement;
        
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                int identifier = sqlite3_column_int(statement, 0);
                int order = sqlite3_column_int(statement, 1);
                int codeDay = sqlite3_column_int(statement, 2);
                char* nameTask = (char*) sqlite3_column_text(statement, 3);
                char* descriptionTask = (char*) sqlite3_column_text(statement, 4);
                int countRepeat = sqlite3_column_int(statement, 5);
                
                TaskModel* task = [[TaskModel alloc] initWithIdentifier: identifier
                                                                  order: order
                                                                codeDay: codeDay
                                                                   name: [NSString stringWithUTF8String:nameTask]
                                                            description: [NSString stringWithUTF8String:descriptionTask]
                                                         andCountRepeat: countRepeat];
                
                [result addObject:task];
                
                [task release];
            }
        }
    }
    
    return result;
}

- (TaskModel*) getTasksByIdTask: (int)idTask
{
    TaskModel* result = [[TaskModel alloc] init];
    if (database != NULL)
    {
        NSString* query = [NSString stringWithFormat:@"SELECT * FROM tasks WHERE id=%d ORDER BY order_task ASC", idTask];
        
        sqlite3_stmt* statement;
        
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                int identifier = sqlite3_column_int(statement, 0);
                int order = sqlite3_column_int(statement, 1);
                int codeDay = sqlite3_column_int(statement, 2);
                char* nameTask = (char*) sqlite3_column_text(statement, 3);
                char* descriptionTask = (char*) sqlite3_column_text(statement, 4);
                int countRepeat = sqlite3_column_int(statement, 5);
                
                result.identifier = identifier;
                result.order = order;
                result.codeDay = codeDay;
                result.nameTask = [NSString stringWithUTF8String:nameTask];
                result.descriptionTask = [NSString stringWithUTF8String:descriptionTask];
                result.countRepeat = countRepeat;
            }
        }
    }
    
    return result;
}

- (void) saveTask: (TaskModel*)task
{
    const char* queryMaxId = "SELECT MAX(id) FROM tasks";
    
    sqlite3_stmt* statement;
    
    int maxId = 0;
    
    if (sqlite3_prepare_v2(database, queryMaxId, -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            maxId = sqlite3_column_int(statement, 0);
        }
    }
    
    const char* update = "INSERT INTO tasks "
                         "(order_task, code_day, name, description, count_repeat) VALUES (?, ?, ?, ?, ?)";
    
    sqlite3_stmt* stmt;
    
    if (sqlite3_prepare_v2(database, update, -1, &stmt, NULL) == SQLITE_OK)
    {
        sqlite3_bind_int(stmt, 1, maxId + 1);
        sqlite3_bind_int(stmt, 2, task.codeDay);
        sqlite3_bind_text(stmt, 3, [task.nameTask UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [task.descriptionTask UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 5, task.countRepeat);
    }
    
    if (sqlite3_step(stmt) == SQLITE_DONE)
    {
        NSLog(@"Inserted task with name: %@", task.nameTask);
    }
    
    sqlite3_finalize(stmt);
}

- (void) updateTask: (TaskModel*)task
{    
    NSString* query = [NSString stringWithFormat:@"UPDATE tasks "
                                                  "SET code_day=?, name=?, description=?, count_repeat=? "
                                                  "WHERE id=%d", task.identifier];
    
    sqlite3_stmt* stmt;
    
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, NULL) == SQLITE_OK)
    {
        sqlite3_bind_int(stmt, 1, task.codeDay);
        sqlite3_bind_text(stmt, 2, [task.nameTask UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [task.descriptionTask UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 4, task.countRepeat);
    }
    
    if (sqlite3_step(stmt) == SQLITE_DONE)
    {
        NSLog(@"Updated row with id: %d", task.identifier);
    }
    
    sqlite3_finalize(stmt);
}

- (void) removeTaskById: (NSInteger)idTask
{
    NSString* query = [NSString stringWithFormat:@"DELETE FROM tasks WHERE id=%d", idTask];
    
    sqlite3_stmt* stmt;
    
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            NSLog(@"Removed row with id: %d", idTask);
        }
    }
    
    sqlite3_finalize(stmt);
}

- (void) removeTaskByCodeDay: (NSInteger)codeDay
{
    NSString* query = [NSString stringWithFormat:@"DELETE FROM tasks WHERE code_day=%d", codeDay];
    
    sqlite3_stmt* stmt;
    
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            NSLog(@"Removed rows by code day: %d", codeDay);
        }
    }
    
    sqlite3_finalize(stmt);
}

- (void) updateOrderTask: (NSInteger)orderTask byId: (NSInteger)idTask
{
    NSString* query = [NSString stringWithFormat:@"UPDATE tasks "
                       "SET order_task = ? "
                       "WHERE id=%d", idTask];
    
    sqlite3_stmt* stmt;
    
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, NULL) == SQLITE_OK)
    {
        sqlite3_bind_int(stmt, 1, orderTask);
    }
    
    if (sqlite3_step(stmt) == SQLITE_DONE)
    {
        NSLog(@"Updated row with id: %d", idTask);
    }
    
    sqlite3_finalize(stmt);
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
