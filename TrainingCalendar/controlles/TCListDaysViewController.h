//
//  TCListDaysViewController.h
//  TrainingCalendar
//
//  Created by user on 23.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCSettingsViewController;
@class TCListTasksViewController;
@class SettingDays;
@protocol TCSettingsDelegate;

@interface TCListDaysViewController : UITableViewController<TCSettingsDelegate>
{
    @private
    TCSettingsViewController* mSettingsViewController;
    TCListTasksViewController* mListTasksViewController;
    UIBarButtonItem* mSettingButton;
    UIBarButtonItem* mBackButton;
    SettingDays* mSettingDays;
}

@end
