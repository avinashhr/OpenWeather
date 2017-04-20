//
//  NSDictionary+AdditionalFeatures.h
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AdditionalFeatures)

- (nullable NSString *)stringWithKey:(nonnull NSString *)key;

- (float)floatWithKey:(nonnull NSString *)key;

- (nullable NSString *)stringForKeyPath:(nonnull NSString *)key;

- (float)floatForKeyPath:(nonnull NSString *)key;

- (nullable id)arrayWithKey:(nonnull NSString *)key;

@end
