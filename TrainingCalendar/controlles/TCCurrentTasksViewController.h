//
//  TCCurrentTasksViewController.h
//  TrainingCalendar
//
//  Created by user on 20.07.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCListDaysViewController;
@class TaskManager;

@interface TCCurrentTasksViewController : UIViewController
{
    @private
    TCListDaysViewController* mListDaysController;
    UIBarButtonItem* mDaysButton;
    UIBarButtonItem* mBackButton;
    TaskManager* mTaskManager;
}

@property (retain, nonatomic) IBOutlet UILabel *nameTask;

@end
