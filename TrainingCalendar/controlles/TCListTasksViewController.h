//
//  TCListTasksViewController.h
//  TrainingCalendar
//
//  Created by user on 29.06.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../TCDataTransfer.h"

@class TCDetailsTaskViewController;
@class DBManager;

@interface TCListTasksViewController : UITableViewController<TCDataTransfer>
{
    @private
    TCDetailsTaskViewController* mDetailsTaskViewController;
    UIBarButtonItem* mAddTaskButton;
    UIBarButtonItem* mBackButton;
    DBManager* mDbManager;
    int mIdDay;
}

@end
