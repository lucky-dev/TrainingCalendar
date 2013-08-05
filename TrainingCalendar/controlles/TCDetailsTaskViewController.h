//
//  TCDetailsTaskViewController.h
//  TrainingCalendar
//
//  Created by user on 29.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../TCDataTransfer.h"

@class DBManager;
@class SettingDays;
@class TaskModel;
@class DBManager;

@interface TCDetailsTaskViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, TCDataTransfer>
{
    @private
    UIBarButtonItem* mSaveTaskButton;
    SettingDays* mSettingDays;
    NSArray* mDays;
    BOOL isEditMode;
    int mIdTask;
    DBManager* mDbManager;
}

@property (retain, nonatomic) IBOutlet UITextField *nameTask;
@property (retain, nonatomic) IBOutlet UITextField *descriptionTask;
@property (retain, nonatomic) IBOutlet UITextField *countRepeat;
@property (retain, nonatomic) IBOutlet UIPickerView* pickerDay;
@property (retain, nonatomic) IBOutlet UIButton *deleteTask;

- (IBAction) backgroundTap: (id)sender;
- (IBAction) deleteTask: (id)sender;

@end
