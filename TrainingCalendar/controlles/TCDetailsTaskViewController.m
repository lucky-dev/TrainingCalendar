//
//  TCDetailsTaskViewController.m
//  TrainingCalendar
//
//  Created by user on 29.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "TCDetailsTaskViewController.h"
#import "TaskModel.h"
#import "DBManager.h"
#import "Utils.h"
#import "SettingDays.h"
#import "SettingDayModel.h"
#import "../utils/Constants.h"

@interface TCDetailsTaskViewController ()

@property (assign, nonatomic) TaskModel* currentTask;
@property (assign, nonatomic) UIAlertView* alert;
@property (assign, nonatomic) NSArray* days;

@end

@implementation TCDetailsTaskViewController

- (id) initWithNibName: (NSString*)nibNameOrNil bundle: (NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = @"Edit details of task";
        
        mSaveTaskButton = [[UIBarButtonItem alloc]
                           initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                           target:self
                           action:@selector(saveTask:)];
        
        self.navigationItem.rightBarButtonItem = mSaveTaskButton;
        
        mSettingDays = [SettingDays sharedManager];
        mDbManager = [DBManager sharedManager];
        
        mDays = [mSettingDays getDaysOnlyEnabled:NO];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (void) viewWillAppear:(BOOL)animated
{
    self.days = [mSettingDays getDaysOnlyEnabled:YES];
    
    self.deleteTask.hidden = (isEditMode ? NO : YES);
    
    if (isEditMode)
    {
        self.currentTask = [mDbManager getTasksByIdTask: mIdTask];
        
        self.nameTask.text = self.currentTask.nameTask;
        self.descriptionTask.text = self.currentTask.descriptionTask;
        self.countRepeat.text = [NSString stringWithFormat:@"%d", self.currentTask.countRepeat];
        
        [self.pickerDay selectRow: self.currentTask.codeDay - 1
                      inComponent: 0
                         animated: NO];
    }
    else
    {
        self.nameTask.text = @"";
        self.descriptionTask.text = @"";
        self.countRepeat.text = @"";
        
        [self.pickerDay selectRow: [Utils getCodeOfCurrentDay] - 1
                      inComponent: 0
                         animated: NO];
    }
    
    [super viewWillAppear:animated];
}

- (void) setCurrentTask: (TaskModel*)value
{
    [_currentTask release];
    _currentTask = value;
}

- (void) setDays: (NSArray*)value
{
    [_days release];
    _days = value;
}

-  (NSInteger) numberOfComponentsInPickerView: (UIPickerView*)pickerView
{
    return 1;
}

- (NSInteger) pickerView: (UIPickerView*)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [mDays count];
}

- (NSString*) pickerView: (UIPickerView*)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component
{
    SettingDayModel* dayModel = mDays[row];
    
    return dayModel.nameDay;
}

- (IBAction) backgroundTap: (id)sender
{
    [self.nameTask resignFirstResponder];
    [self.descriptionTask resignFirstResponder];
    [self.countRepeat resignFirstResponder];
}

- (IBAction) deleteTask: (id)sender
{
    [mDbManager removeTaskById: mIdTask];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) saveTask: (id)sender
{
    if (![self isValidFields])
    {
        return;
    }
    
    SettingDayModel* dayModel = mDays[[self.pickerDay selectedRowInComponent: 0]];
    
    self.currentTask = [[TaskModel alloc] initWithIdentifier: self.currentTask.identifier
                                                       order: self.currentTask.order
                                                     codeDay: dayModel.codeDay
                                                        name: self.nameTask.text
                                                 description: self.descriptionTask.text
                                              andCountRepeat: [self.countRepeat.text intValue]];
    
    if (isEditMode)
    {
        [mDbManager updateTask: self.currentTask];
    }
    else
    {
        [mDbManager saveTask: self.currentTask];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setBundle: (NSDictionary*)data
{
    isEditMode = [[data valueForKey: IS_EDIT_MODE] boolValue];
    mIdTask = [[data valueForKey: ID_TASK] intValue];
}

- (BOOL) isValidFields
{
    BOOL flag = YES;
    
    NSString* msg = nil;
    
    if ([self.nameTask.text length] == 0)
    {
        msg = @"Name of task can't be empty";
        flag = NO;
    } else if ([self.descriptionTask.text length] == 0)
    {
        msg = @"Description of task can't be empty";
        flag = NO;
    } else if ([self.countRepeat.text length] == 0)
    {
        msg = @"Count repeat can't be empty";
        flag = NO;
    }
    
    SettingDayModel* dayModel = mDays[[self.pickerDay selectedRowInComponent: 0]];
        
    if (![dayModel status])
    {
        msg = [NSString stringWithFormat: @"Turn on %@ in settings", dayModel.nameDay];
        flag = NO;
    }
    
    if (!flag)
    {
        self.alert = [[UIAlertView alloc]
                      initWithTitle:@"Error"
                      message:msg
                      delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil,
                      nil];
    
        [self.alert show];
    }
    
    return flag;
}

- (void) dealloc
{
    self.navigationItem.rightBarButtonItem = nil;
    self.currentTask = nil;
    self.alert = nil;
    self.days = nil;
    
    [mSaveTaskButton release];
    [mDays release];
    [_nameTask release];
    [_descriptionTask release];
    [_countRepeat release];
    [_pickerDay release];
    [_deleteTask release];
    
    [super dealloc];
}

@end
