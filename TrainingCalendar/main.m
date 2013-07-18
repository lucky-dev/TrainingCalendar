//
//  main.m
//  TrainingCalendar
//
//  Created by user on 19.05.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TCAppDelegate.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([TCAppDelegate class]));
    [pool drain];
    
    return retVal;
}
