//
//  NSDictionary+AdditionalFeatures.m
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import "NSDictionary+AdditionalFeatures.h"

@implementation NSDictionary (AdditionalFeatures)

- (nullable NSString *)stringWithKey:(nonnull NSString *)key {
    return [self objectForKey:key ofType:[NSString class]];
}

- (float)floatWithKey:(nonnull NSString *)key {
    return [[self objectForKey:key ofType:[NSNumber class]] floatValue];
}

- (nullable id)arrayWithKey:(nonnull NSString *)key {
    return [self objectForKey:key ofType:[NSArray class]];
}

- (nullable id)objectForKey:(nonnull NSString *)key ofType:(nonnull Class)type {
    id theObject = [self objectForKey:key];
    
    return ([theObject isKindOfClass:type] ? theObject : nil);
}

- (nullable NSString *)stringForKeyPath:(nonnull NSString *)keyPath {
    return [self valueForKeyPath:keyPath ofType:[NSString class]];
}

- (NSInteger)integerForKeyPath:(nonnull NSString *)keyPath {
    return [[self valueForKeyPath:keyPath ofType:[NSNumber class]] integerValue];

}

- (float)floatForKeyPath:(nonnull NSString *)keyPath {
    return [[self valueForKeyPath:keyPath ofType:[NSNumber class]] floatValue];

}

- (nullable id)valueForKeyPath:(nonnull NSString *)keyPath ofType:(nonnull Class)type {
    id theObject = [self valueForKeyPath:keyPath];
    
    return ([theObject isKindOfClass:type] ? theObject : nil);
}
@end
