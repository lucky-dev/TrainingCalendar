//
//  TCListDaysViewController.m
//  TrainingCalendar
//
//  Created by user on 23.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "TCListDaysViewController.h"
#import "TCListTasksViewController.h"
#import "TCSettingsViewController.h"
#import "SettingDays.h"
#import "SettingDayModel.h"
#import "../utils/Constants.h"

static NSString* CellIdentifier = @"CellDay";

@interface TCListDaysViewController ()

    - (void) openSettings: (id)sender;

    @property (assign, nonatomic) NSArray* days;

@end

@implementation TCListDaysViewController

- (id) initWithStyle: (UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
        // Custom initialization
        self.title = @"Days";
        
        mSettingsViewController = [[TCSettingsViewController alloc] init];
        mSettingsViewController.delegate = self;
        
        mListTasksViewController = [[TCListTasksViewController alloc] init];
        
        mSettingButton = [[UIBarButtonItem alloc]
                          initWithTitle:@"Settings"
                          style:UIBarButtonItemStylePlain
                          target:self
                          action:@selector(openSettings:)];
        
        mBackButton = [[UIBarButtonItem alloc]
                       initWithTitle:@"Back"
                       style:UIBarButtonItemStylePlain
                       target:nil
                       action:nil];
        
        self.navigationItem.backBarButtonItem = mBackButton;
        self.navigationItem.rightBarButtonItem = mSettingButton;
        
        mSettingDays = [SettingDays sharedManager];
        
        self.days = [mSettingDays getDaysOnlyEnabled:YES];
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

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView: (UITableView*)tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*)tableView numberOfRowsInSection: (NSInteger)section
{
    return [self.days count];
}

- (UITableViewCell*) tableView: (UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*) indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    SettingDayModel* settingItem = [self.days objectAtIndex:indexPath.row];
    cell.textLabel.text = settingItem.nameDay;
    
    return cell;
}

#pragma mark - Table view delegate

- (void) tableView: (UITableView*)tableView didSelectRowAtIndexPath: (NSIndexPath*)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SettingDayModel* settingDay = self.days[indexPath.row];
    
    NSNumber* idDay = [[NSNumber alloc] initWithInt: settingDay.codeDay];
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys: idDay, ID_DAY, nil];
    
    [mListTasksViewController setBundle:params];
    
    [idDay release];
    [params release];
    
    [self.navigationController pushViewController:mListTasksViewController animated:YES];
}

#pragma mark - Other methods

- (void) didUpdatingDay: (NSString*)nameDay andStatus: (BOOL)status
{
    self.days = [mSettingDays getDaysOnlyEnabled:YES];
    
    NSLog(@"%@ : %d", nameDay, status);
    
    [self.tableView reloadData];
}

- (void) setDays: (NSArray*)value
{
    [_days release];
    _days = value;
}

//Helper methods
- (void) openSettings: (id)sender
{
    [self.navigationController pushViewController:mSettingsViewController animated:YES];
}
//~~~

- (void) dealloc
{
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.backBarButtonItem = nil;
    self.days = nil;
    
    [mSettingButton release];
    [mBackButton release];
    [mSettingsViewController release];
    [mListTasksViewController release];
    
    [super dealloc];
}

@end
