//
//  Utility.m
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import "Utility.h"
#import "OWConstants.h"

@implementation Utility

+ (NSString *)getErrorMessageForErrorCode:(NSInteger)errorCode {
    
    NSString *errorMessage = defaultErrorMessage;
    
    switch (errorCode) {
        case noDataErrorCode:
            errorMessage = noDataErrorMessage;
            break;
        case noNetworkErrorCode:
            errorMessage = noNetworkErrorMessage;
            break;
            
        default:
            errorMessage = defaultErrorMessage;
            
            break;
    }
    
    return errorMessage;
}

+ (NSString *) getLocalTime:(double)unixTime {
    // API refrence describes that time is Unix UTC time converting it to local time
    NSDate *utcDate = [NSDate dateWithTimeIntervalSince1970:unixTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:[NSLocale systemLocale].localeIdentifier];
    dateFormatter.dateFormat = @"hh:mm a";

    return [dateFormatter stringFromDate:utcDate];
}

@end
