//
//  Utility.h
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (NSString *)getErrorMessageForErrorCode:(NSInteger)errorCode;
+ (NSString *) getLocalTime:(double)unixTime;

@end
