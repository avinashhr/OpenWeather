//
//  OWServiceWrapper.h
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OWStatus.h"

@interface OWServiceWrapper : NSObject

- (void) retrieveCurrentWeatherForCity:(NSString *)cityName ofCountry:(NSString *)countryName inUnits:(NSString *)units withCompletionBlock:(void(^)(OWStatus *))completionBlock;
- (void) getWeatherIconWithId:(NSString *)iconId andCompletionBlock:(void(^)(UIImage *))completionBlock;

@end
