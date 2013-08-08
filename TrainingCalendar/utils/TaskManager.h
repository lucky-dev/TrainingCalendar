//
//  TaskManager.h
//  TrainingCalendar
//
//  Created by user on 07.08.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBManager;
@class TaskModel;

@interface TaskManager : NSObject

+ (TaskManager*) sharedManager;
- (TaskModel*) getTaskByCodeDay: (NSInteger)codeDay;

@end
