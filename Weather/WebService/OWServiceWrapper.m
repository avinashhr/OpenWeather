//
//  OWServiceWrapper.m
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import "OWServiceWrapper.h"
#import "OWServiceManager.h"
#import "OWConstants.h"
#import "Utility.h"
#import "OWDataManager.h"

@interface OWServiceWrapper()

@property (nonatomic, strong) OWServiceManager *serviceManager;

@end

@implementation OWServiceWrapper

-(id) init {
    
    self = [super init];
    
    if (self) {
        self.serviceManager = [[OWServiceManager alloc] init];
    }
    
    return self;
}

- (void) retrieveCurrentWeatherForCity:(NSString *)cityName ofCountry:(NSString *)countryName inUnits:(NSString *)units withCompletionBlock:(void(^)(OWStatus *))completionBlock {

    NSString *api;
    
    api = [NSString stringWithFormat:@"%@?q=%@,%@&units=%@", weatherByCityName, cityName, countryName, units];
    
    OWStatus *status = [[OWStatus alloc] init];
    
    [self.serviceManager getDataFromAPI:api withSuccessCallBack:^(id response) {
        NSError *parseError = [self parseWeatherResponse:response];
        
        if (parseError) {
            status.statusCode = parseError.code;
            status.statusMessage = [Utility getErrorMessageForErrorCode:parseError.code];
        } else {
            status.statusCode = 0;
        }
        
        completionBlock (status);
        
    } andFailureCallBack:^(NSError *error) {
        status.statusCode = error.code;
        
        status.statusMessage = [Utility getErrorMessageForErrorCode:error.code];
        completionBlock (status);
    }];
}

- (NSError*) parseWeatherResponse:(id)response {
    
    NSError *error = nil;
    
    if([response isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDictionary = (NSDictionary *)response;
        OWWeather *weather = [[OWWeather alloc]initWithDictionary:responseDictionary];
        [[OWDataManager sharedDataManager] updateCurrentWeatherOfSearchedCity:weather];
        
    } else {
        error = [NSError errorWithDomain:errorDomian code:noDataErrorCode userInfo:@{@"errorMessage" : noDataErrorMessage}];
    }
    
    return error;
}

- (void) getWeatherIconWithId:(NSString *)iconId andCompletionBlock:(void(^)(UIImage *))completionBlock {
    
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *path = [pathsArray firstObject];
    NSString *imageName = [NSString stringWithFormat:@"/%@", iconId];
    NSString *imagePath = [path stringByAppendingString:imageName];
    UIImage *downloadedImage;
    
    // if image is already there don't download
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        downloadedImage = [UIImage imageWithContentsOfFile:imagePath];
        completionBlock (downloadedImage);
    } else {
        // download image from server
        [self.serviceManager downloadImage:[NSString stringWithFormat:@"%@/%@",weatherConditionIcon, iconId] withSuccessCallBack:^(NSURL* location) {
            
            NSData *imageData = [NSData dataWithContentsOfURL:location];
            [imageData writeToFile:imagePath atomically:YES];
            UIImage *downloadedImage = [UIImage imageWithData:
                                        [NSData dataWithContentsOfURL:location]];
            completionBlock(downloadedImage);
            // return nil if no error
        } andFailureCallBack:^(NSError *error) {
            completionBlock(nil);
        }];
        
    }
}

@end
