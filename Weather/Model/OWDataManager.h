//
//  OWDataManager.h
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWWeather.h"

@interface OWDataManager : NSObject

+(OWDataManager *)sharedDataManager;

-(void)updateCurrentWeatherOfSearchedCity:(OWWeather *)weather;
-(OWWeather *) getCurrentWeatherOfSearchedCity;


@end
