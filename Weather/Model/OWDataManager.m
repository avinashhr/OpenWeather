//
//  OWDataManager.m
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import "OWDataManager.h"

@interface OWDataManager()

@property (nonatomic, strong) OWWeather *currentWeather;

@end

@implementation OWDataManager

+(OWDataManager *)sharedDataManager {
    static OWDataManager *dataManager = nil;
    static dispatch_once_t dispatchOnce;
    
    dispatch_once(&dispatchOnce, ^{
        dataManager = [[OWDataManager alloc] init];
    });
    
    return dataManager;
}
-(void)updateCurrentWeatherOfSearchedCity:(OWWeather *)weather {
    self.currentWeather = [weather copy];
}

-(OWWeather *) getCurrentWeatherOfSearchedCity {
    return self.currentWeather;
}

@end
