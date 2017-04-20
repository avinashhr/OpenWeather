//
//  OWServiceManager.m
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import "OWServiceManager.h"
#import "OWConstants.h"

static NSString *APPID = @"72d6d43bf794eb35d92e8fa9a5dec1c3";

@implementation OWServiceManager

- (void) getDataFromAPI:(NSString *)apiName withSuccessCallBack:(void(^) (id))successBlock andFailureCallBack:(void(^) (NSError *))failureBlock{
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[self formURLForAPI:apiName]];
    // create data task
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Response %@", responseString);
        if (error) {
            
            failureBlock (error);
            
        } else {
            
            NSError *jsonError;
            id jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            successBlock(jsonResponse);
            
        }
        
    }];
    
    [dataTask resume];
    
}

- (void) downloadImage:(NSString *)imageName withSuccessCallBack:(void(^) (NSURL *))successBlock andFailureCallBack:(void(^) (NSError *))failureBlock {
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURL, imageName]]];
    // create download task
    NSURLSessionTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error) {
            
            failureBlock (error);
            
        } else {
            
            successBlock(location);
            
        }
        
    }];
    
    [downloadTask resume];
    
}

#pragma mark - private methods
- (NSURL *)formURLForAPI:(NSString *)apiName {
    NSString *urlString = [NSString stringWithFormat:@"%@%@&APPID=%@",baseURL, apiName, APPID];
    
    return [NSURL URLWithString:urlString];
}

@end
