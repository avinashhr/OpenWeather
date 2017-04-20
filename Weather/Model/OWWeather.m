//
//  OWWeather.m
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import "OWWeather.h"
#import "Utility.h"
#import "NSDictionary+AdditionalFeatures.h"

@implementation OWWeather


/* 1. given time I would have wrapped parsing logic in a base model and pass specific dictionary to different sub models.
 2. passiing whole response JSON to this method and tkeeping parsing logic in model class helps kepp code structured.
 3. I would have created constants for the keys
 */

- (OWWeather *)initWithDictionary:(NSDictionary *)dictionary {
    OWWeather *weatherObject = [[OWWeather alloc] init];
    weatherObject.location = CLLocationCoordinate2DMake([dictionary floatForKeyPath:@"coord.lat"], [dictionary floatForKeyPath:@"coord.lon"]);
    weatherObject.cityName = [dictionary stringWithKey:@"name"];
    weatherObject.temprature = [dictionary floatForKeyPath:@"main.temp"];
    weatherObject.pressure = [dictionary floatForKeyPath:@"main.pressure"];
    weatherObject.humidity = [dictionary floatForKeyPath:@"main.humidity"];
    weatherObject.windSpeed = [dictionary floatForKeyPath:@"wind.speed"];
    weatherObject.cloud = [dictionary floatForKeyPath:@"clouds.all"];
    weatherObject.visibility = lroundf([dictionary floatWithKey:@"visibility"]/1609.34); // converting to miles
    weatherObject.sunRiseTime = [Utility getLocalTime:[dictionary floatForKeyPath:@"sys.sunrise"]];
    weatherObject.sunSetTime = [Utility getLocalTime:[dictionary floatForKeyPath:@"sys.sunset"]];

    // considering only first object from Group of weather parameters
    NSArray *weatherArray = [dictionary arrayWithKey:@"weather"];
    
    if (weatherArray.count > 0) {
        weatherObject.iconID = [weatherArray[0] stringWithKey:@"icon"];
        weatherObject.weatherDescription = [weatherArray[0] stringWithKey:@"description"];

    }

    self = weatherObject;
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    
    OWWeather *copyObject = [[OWWeather alloc] init];
    copyObject.location = self.location;
    copyObject.cityName = [self.cityName copy];
    copyObject.temprature = self.temprature;
    copyObject.pressure = self.pressure;
    copyObject.humidity = self.humidity;
    copyObject.windSpeed = self.windSpeed;
    copyObject.cloud = self.cloud;
    copyObject.visibility = self.visibility;
    copyObject.sunRiseTime = [self.sunRiseTime copy];
    copyObject.sunSetTime = [self.sunSetTime copy];
    copyObject.iconID = [self.iconID copy];
    copyObject.weatherDescription = [self.weatherDescription copy];


    return copyObject;
}

@end
