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

@interface TCCurrentTasksViewController ()

    - (void) openSettings: (id)sender;

    @property (assign, nonatomic) NSArray* tasks;

@end

static NSString* CellIdentifier = @"CellTask";

@implementation TCCurrentTasksViewController

- (id) initWithStyle: (UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    self.tasks = [mDbManager getTasksByDay:[Utils getCodeOfCurrentDay]];
    
    [self.tableView reloadData];
    
    [super viewWillAppear:animated];
}

- (void) setTasks: (NSArray*)value
{
    [_tasks release];
    _tasks = value;
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
    
    TaskModel* taskItem = [self.tasks objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = taskItem.nameTask;
    
    return cell;
}

#pragma mark - Table view delegate

- (void) tableView: (UITableView*)tableView didSelectRowAtIndexPath: (NSIndexPath*)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//Helper methods
- (void) openSettings: (id)sender
{
    [self.navigationController pushViewController:mListDaysController animated:YES];
}
//~~~

- (void) dealloc
{
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.backBarButtonItem = nil;
    
    [mDaysButton release];
    [mBackButton release];
    [mListDaysController release];
    
    [super dealloc];
}

@end
