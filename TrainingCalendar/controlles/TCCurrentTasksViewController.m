//
//  TCCurrentTasksViewController.m
//  TrainingCalendar
//
//  Created by user on 20.07.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "TCCurrentTasksViewController.h"
#import "TCListDaysViewController.h"
#import "Utils.h"
#import "DBManager.h"
#import "TaskModel.h"
#import "DBManager.h"
#import "TaskManager.h"

@interface TCCurrentTasksViewController ()

    - (void) openSettings: (id)sender;

    @property (assign, nonatomic) TaskModel* task;
    @property (assign, nonatomic) NSArray* counterTasks;

@end

@implementation TCCurrentTasksViewController

- (id) initWithNibName: (NSString*)nibNameOrNil bundle: (NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = [Utils getNameOfCurrentDay];
        
        mListDaysController = [[TCListDaysViewController alloc] init];
        
        mDaysButton = [[UIBarButtonItem alloc]
                       initWithTitle: @"Days"
                       style: UIBarButtonItemStylePlain
                       target:self
                       action:@selector(openSettings:)];
        
        mBackButton = [[UIBarButtonItem alloc]
                       initWithTitle:@"Back"
                       style:UIBarButtonItemStylePlain
                       target:nil
                       action:nil];
        
        self.navigationItem.rightBarButtonItem = mDaysButton;
        self.navigationItem.backBarButtonItem = mBackButton;
        
        mTaskManager = [TaskManager sharedManager];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear: (BOOL)animated
{
    self.task = [mTaskManager getTaskByCodeDay: [Utils getCodeOfCurrentDay]];
    
    self.nameTask.text = self.task.nameTask;
    
    [super viewWillAppear:animated];
}

- (void) setTask: (TaskModel*)value
{
    [_task release];
    _task = value;
}

- (void) setCounterTasks:(NSArray *) value
{
    [_counterTasks release];
    _counterTasks = value;
}

#pragma mark - Helper methods
- (void) openSettings: (id)sender
{
    [self.navigationController pushViewController:mListDaysController animated:YES];
}

#pragma mark -

- (void) dealloc
{
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.backBarButtonItem = nil;
    
    self.task = nil;
    
    [mDaysButton release];
    [mBackButton release];
    [mListDaysController release];
    
    [super dealloc];
}

@end
