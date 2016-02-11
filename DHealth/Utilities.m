//
//  Utilities.m
//  DHealth
//
//  Created by inovaitsys on 2/2/16.
//  Copyright © 2016 INOVA. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths =   NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}


+(NSString *)getPresentDateTime{
    
    NSDateFormatter *dateTimeFormat = [[NSDateFormatter alloc] init];
    [dateTimeFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
    NSDate *now = [[NSDate alloc] init];
    
    NSString *theDateTime = [dateTimeFormat stringFromDate:now];
    
    dateTimeFormat = nil;
    now = nil;
    
    return theDateTime;
}

@end
