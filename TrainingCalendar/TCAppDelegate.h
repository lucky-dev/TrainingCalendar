//
//  TCAppDelegate.h
//  TrainingCalendar
//
//  Created by user on 19.05.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCCurrentTasksViewController;

@interface TCAppDelegate : UIResponder <UIApplicationDelegate>
{
    @private
    UINavigationController* mNavigation;
    TCCurrentTasksViewController* mCurrentTasksController;
}

@property (retain, nonatomic) UIWindow* window;

@end
