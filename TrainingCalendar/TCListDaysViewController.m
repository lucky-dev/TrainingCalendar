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

static NSString *CellIdentifier = @"CellDays";

@interface TCListDaysViewController ()

    @property(assign, nonatomic) NSArray *days;

@end

@implementation TCListDaysViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
        self.title = @"Days";
        
        self.days = [[SettingDays sharedManager] getDaysOnlyEnabled:YES];
        
        mSettingsViewController = [[TCSettingsViewController alloc] init];
        mSettingsViewController.delegate = self;
        
        mListTasksViewController = [[TCListTasksViewController alloc] init];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithTitle:@"Settings"
                                                  style:UIBarButtonSystemItemAction
                                                  target:self
                                                  action:@selector(openSettings:)];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:CellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.days count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    SettingDayModel *settingItem = [self.days objectAtIndex:indexPath.row];
    cell.textLabel.text = settingItem.nameDay;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:mListTasksViewController animated:YES];
}

- (void)didUpdatingDay:(NSString* ) nameDay andStatus:(BOOL) status
{
    self.days = [[SettingDays sharedManager] getDaysOnlyEnabled:YES];
    
    NSLog(@"%@ : %d", nameDay, status);
    
    [self.tableView reloadData];
}

- (void)setDays: (NSArray* ) value
{
    [_days release];
    _days = value;
}

//Helper methods
- (void)openSettings:(id)sender
{
    [self.navigationController pushViewController:mSettingsViewController animated:YES];
}
//~~~

- (void)dealloc
{
    [self.days release];
    [mSettingsViewController release];
    [mListTasksViewController release];
    
    [super dealloc];
}

@end
