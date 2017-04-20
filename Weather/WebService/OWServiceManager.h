//
//  OWServiceManager.h
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWServiceManager : NSObject


- (void) getDataFromAPI:(NSString *)apiName withSuccessCallBack:(void(^) (id))successBlock andFailureCallBack:(void(^) (NSError *))failureBlock;

- (void) downloadImage:(NSString *)imageName withSuccessCallBack:(void(^) (NSURL *))successBlock andFailureCallBack:(void(^) (NSError *))failureBlock;

@end
