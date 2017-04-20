//
//  OWStatus.h
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWStatus : NSObject

@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong) NSString *statusMessage;

@end
