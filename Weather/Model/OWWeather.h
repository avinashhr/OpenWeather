//
//  OWWeather.h
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

// model has only required parameters, given time I would like to create different model classes for different category of data
@interface OWWeather : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, assign) float temprature;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSString *iconID;
@property (nonatomic, assign) float pressure;
@property (nonatomic, assign) float humidity;
@property (nonatomic, assign) float windSpeed;
@property (nonatomic, assign) float cloud;
@property (nonatomic, assign) long int visibility;
@property (nonatomic, strong) NSString *sunRiseTime;
@property (nonatomic, strong) NSString *sunSetTime;
@property (nonatomic, strong) NSString *cityName;

- (OWWeather *)initWithDictionary:(NSDictionary *)dictionary;



@end
