//
//  TCCurrentTasksViewController.h
//  TrainingCalendar
//
//  Created by user on 20.07.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCListDaysViewController;
@class DBManager;

@interface TCCurrentTasksViewController : UITableViewController
{
    @private
    TCListDaysViewController* mListDaysController;
    UIBarButtonItem* mDaysButton;
    UIBarButtonItem* mBackButton;
    DBManager* mDbManager;
}

@end
