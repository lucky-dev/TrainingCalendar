//
//  Utils.h
//  TrainingCalendar
//
//  Created by user on 20.07.13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString*) getNameOfCurrentDay;
+ (NSInteger) getCodeOfCurrentDay;
+ (NSDate*) getDefaultDate;
+ (NSDate*) getNowDate;

@end
