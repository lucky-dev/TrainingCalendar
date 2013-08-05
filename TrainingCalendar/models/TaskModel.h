//
//  TaskModel.h
//  TrainingCalendar
//
//  Created by user on 22.07.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject

@property (assign, nonatomic) NSInteger identifier;
@property (assign, nonatomic) NSInteger order;
@property (assign, nonatomic) NSInteger codeDay;
@property (retain, nonatomic) NSString* nameTask;
@property (retain, nonatomic) NSString* descriptionTask;
@property (assign, nonatomic) NSInteger countRepeat;

- (TaskModel*) initWithIdentifier: (NSInteger)identifier
                            order: (NSInteger)order
                          codeDay: (NSInteger)codeDay
                             name: (NSString*)nameTask
                      description: (NSString*)descriptionTask
                   andCountRepeat: (NSInteger)countRepeat;

- (TaskModel*) initWithCodeDay: (NSInteger)codeDay
                          name: (NSString*)nameTask
                   description: (NSString*)descriptionTask
                andCountRepeat: (NSInteger)countRepeat;

@end
