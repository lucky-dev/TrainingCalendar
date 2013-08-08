//
//  TCListTasksViewController.m
//  TrainingCalendar
//
//  Created by user on 29.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "TCListTasksViewController.h"
#import "TCDetailsTaskViewController.h"
#import "DBManager.h"
#import "Utils.h"
#import "TaskModel.h"
#import "../utils/Constants.h"

@interface TCListTasksViewController ()

    - (void) addTask: (id)sender;

    @property (assign, nonatomic) NSArray* tasks;

@end

static NSString* CellIdentifier = @"CellTask";

@implementation TCListTasksViewController

- (id) initWithStyle: (UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
        // Custom initialization
        self.title = @"Tasks";
        
        mDetailsTaskViewController = [[TCDetailsTaskViewController alloc] initWithNibName: @"DetailsTask" bundle: nil];
        
        mAddTaskButton = [[UIBarButtonItem alloc]
                          initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                          target:self
                          action:@selector(addTask:)];
        
        mBackButton = [[UIBarButtonItem alloc]
                       initWithTitle:@"Back"
                       style:UIBarButtonItemStylePlain
                       target:nil
                       action:nil];
        
        self.navigationItem.rightBarButtonItem = mAddTaskButton;
        self.navigationItem.backBarButtonItem = mBackButton;
        
        mDbManager = [DBManager sharedManager];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
                                forCellReuseIdentifier:CellIdentifier];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear: (BOOL)animated
{
    self.tasks = [mDbManager getTasksByDay: mIdDay];
    
    [self.tableView reloadData];
    
    [super viewWillAppear:animated];
}

- (void) setTasks: (NSArray*)value
{
    [_tasks release];
    _tasks = value;
}

- (void) addTask: (id)sender
{
    NSNumber* editMode = [[NSNumber alloc] initWithBool:false];
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys: editMode, IS_EDIT_MODE, nil];
    
    [mDetailsTaskViewController setBundle:params];
    
    [editMode release];
    [params release];
    
    [self.navigationController pushViewController:mDetailsTaskViewController animated:YES];
}

- (void) setBundle: (NSDictionary*)data
{
    mIdDay = [[data valueForKey: ID_DAY] intValue];
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView: (UITableView*)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger) tableView: (UITableView*)tableView numberOfRowsInSection: (NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tasks count];
}

- (UITableViewCell*) tableView: (UITableView*)tableView cellForRowAtIndexPath: (NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    TaskModel* task = self.tasks[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = task.nameTask;
    
    return cell;
}

#pragma mark - Table view delegate

- (void) tableView: (UITableView*)tableView didSelectRowAtIndexPath: (NSIndexPath*)indexPath
{
    TaskModel* task = self.tasks[indexPath.row];
    
    NSNumber* editMode = [[NSNumber alloc] initWithBool: YES];
    NSNumber* idTask = [[NSNumber alloc] initWithInt: task.identifier];
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys: editMode, IS_EDIT_MODE,
                                                                         idTask, ID_TASK,
                                                                         nil];
    
    [mDetailsTaskViewController setBundle:params];
    
    [editMode release];
    [idTask release];
    [params release];
    
    [self.navigationController pushViewController:mDetailsTaskViewController animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) dealloc
{
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.backBarButtonItem = nil;
    self.tasks = nil;
    
    [mAddTaskButton release];
    [mBackButton release];
    [mDetailsTaskViewController release];
    
    [super dealloc];
}

@end
