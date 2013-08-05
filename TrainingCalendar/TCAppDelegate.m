//
//  TCAppDelegate.m
//  TrainingCalendar
//
//  Created by user on 19.05.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "TCAppDelegate.h"
#import "TCCurrentTasksViewController.h"

@implementation TCAppDelegate

- (BOOL) application: (UIApplication*)application didFinishLaunchingWithOptions: (NSDictionary*)launchOptions
{
//    NSLog(@"%s", __FUNCTION__);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //Set first controller
    mCurrentTasksController = [[TCCurrentTasksViewController alloc] init];
    mNavigation = [[UINavigationController alloc] initWithRootViewController:mCurrentTasksController];
    self.window.rootViewController = mNavigation;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) applicationWillResignActive: (UIApplication*)application
{
//    NSLog(@"%s", __FUNCTION__);
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void) applicationDidEnterBackground: (UIApplication*)application
{
//    NSLog(@"%s", __FUNCTION__);
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void) applicationWillEnterForeground: (UIApplication*)application
{
//    NSLog(@"%s", __FUNCTION__);
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void) applicationDidBecomeActive: (UIApplication*)application
{
//    NSLog(@"%s", __FUNCTION__);
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void) applicationWillTerminate: (UIApplication*)application
{
//    NSLog(@"%s", __FUNCTION__);
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) dealloc
{
    [mCurrentTasksController release];
    [mNavigation release];
    [_window release];
    
    [super dealloc];
}

@end
