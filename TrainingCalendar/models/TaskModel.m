//
//  TaskModel.m
//  TrainingCalendar
//
//  Created by user on 22.07.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel

- (TaskModel*) initWithIdentifier: (NSInteger)identifier
                            order: (NSInteger)order
                          codeDay: (NSInteger)codeDay
                             name: (NSString*)nameTask
                      description: (NSString*)descriptionTask
                   andCountRepeat: (NSInteger)countRepeat
{
    self = [self initWithCodeDay: codeDay
                            name: nameTask
                     description: descriptionTask
                  andCountRepeat: countRepeat];
    
    if (self)
    {
        self.identifier = identifier;
        self.order = order;
    }
    
    return self;
}

- (TaskModel*) initWithCodeDay: (NSInteger)codeDay
                          name: (NSString*)nameTask
                   description: (NSString*)descriptionTask
                andCountRepeat: (NSInteger)countRepeat
{
    self = [super init];
    
    if (self)
    {
        self.codeDay = codeDay;
        self.nameTask = nameTask;
        self.descriptionTask = descriptionTask;
        self.countRepeat = countRepeat;
    }
    
    return self;
}

- (void) dealloc
{
    NSLog(@"dealloc %@", self.nameTask);
    
    self.nameTask = nil;
    self.descriptionTask = nil;
    
    [super dealloc];
}

@end
