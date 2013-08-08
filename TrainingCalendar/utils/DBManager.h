//
//  DBManager.h
//  TrainingCalendar
//
//  Created by user on 21.07.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class TaskModel;

@interface DBManager : NSObject

+ (DBManager*) sharedManager;
- (NSArray*) getTasksByDay: (int)codeDay;
- (void) saveTask: (TaskModel*)task;
- (void) updateTask: (TaskModel*)task;
- (TaskModel*) getTasksByIdTask: (int)idTask;
- (void) removeTaskById: (NSInteger)idTask;
- (void) removeTaskByCodeDay: (NSInteger)codeDay;

@end
