//
//  TCSettingsViewController.h
//  TrainingCalendar
//
//  Created by user on 23.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TCSettingsDelegate;
@class SettingDays;

@interface TCSettingsViewController : UITableViewController<UIAlertViewDelegate>
{
    @private
    NSArray* mDays;
    UISwitch* mSwitchDay;
    SettingDays* mSettingDays;
}

@property (assign, nonatomic) id<TCSettingsDelegate> delegate;

@end

@protocol TCSettingsDelegate <NSObject>

- (void)didUpdatingDay: (NSString*)nameDay andStatus: (BOOL)status;

@end