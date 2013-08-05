//
//  TCSettingsViewController.m
//  TrainingCalendar
//
//  Created by user on 23.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "TCSettingsViewController.h"
#import "TCSettingsCell.h"
#import "SettingDayModel.h"
#import "SettingDays.h"

#define kOkButton 0

static NSString* CellIdentifier = @"CellSetting";

@interface TCSettingsViewController ()

    @property (assign, nonatomic) UIAlertView* alert;

@end

@implementation TCSettingsViewController

- (id) initWithStyle: (UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
        self.title = @"Settings";
        
        mSettingDays = [SettingDays sharedManager];
        
        mDays = [mSettingDays getDaysOnlyEnabled:NO];
    }
    
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"SettingsCell" bundle:nil]
                                forCellReuseIdentifier:CellIdentifier];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setAlert: (UIAlertView*)alert
{
    [_alert release];
    _alert = alert;
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
    return [mDays count];
}

- (UITableViewCell*) tableView: (UITableView*)tableView cellForRowAtIndexPath: (NSIndexPath*)indexPath
{
    TCSettingsCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [cell.switchDay addTarget:self
                    action:@selector(switchChanged:)
                    forControlEvents:UIControlEventValueChanged];
    
    SettingDayModel* settingItem = [mDays objectAtIndex:indexPath.row];
    
    cell.nameDay.text = settingItem.nameDay;
    cell.switchDay.on = settingItem.status;
    cell.switchDay.tag = indexPath.row;
    
    return cell;
}

#pragma mark - Table view delegate

- (void) tableView: (UITableView*)tableView didSelectRowAtIndexPath: (NSIndexPath*)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) switchChanged: (id)sender
{
    mSwitchDay = sender;
    
    self.alert = [[UIAlertView alloc]
                  initWithTitle:@"Change day"
                  message:@"Are you sure to want to change day?"
                  delegate:self
                  cancelButtonTitle:nil
                  otherButtonTitles:@"Yes", @"No",
                  nil];
    
    [self.alert show];

}

- (void) alertView: (UIAlertView*)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex == kOkButton)
    {
        int indexRow = mSwitchDay.tag;
        
        SettingDayModel* settingItem = [mDays objectAtIndex:indexRow];
        settingItem.status = !settingItem.status;
        
        [mSettingDays saveDays:mDays];
        
        [self.delegate didUpdatingDay:settingItem.nameDay andStatus:settingItem.status];
        
        [self.tableView reloadData];
    }
    else
    {
        [mSwitchDay setOn:!mSwitchDay.on animated:YES];
    }
}

- (void) dealloc
{
    self.alert = nil;
    
    [mDays release];
    
    [super dealloc];
}

@end
