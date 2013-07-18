//
//  TCAppDelegate.h
//  TrainingCalendar
//
//  Created by user on 19.05.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCListDaysViewController;

@interface TCAppDelegate : UIResponder <UIApplicationDelegate>
{
    @private
    UINavigationController *mNavigation;
    TCListDaysViewController *mListDaysController;
}

@property (retain, nonatomic) UIWindow *window;

@end
