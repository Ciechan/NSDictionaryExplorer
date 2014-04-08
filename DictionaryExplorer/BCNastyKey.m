//
//  BCNastyKey.m
//  DictionaryExplorer
//
//  Created by Bartosz Ciechanowski on 07.04.2014.
//  Copyright (c) 2014 Bartosz Ciechanowski. All rights reserved.
//

#import "BCNastyKey.h"

@implementation BCNastyKey

+ (instancetype)keyWithHashValue:(NSUInteger)hashValue
{
    return [[BCNastyKey alloc] initWithHashValue:hashValue];
}

- (instancetype)initWithHashValue:(NSUInteger)hashValue
{
    self = [super init];
    if (self) {
        _hashValue = hashValue;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSUInteger)hash
{
    NSLog(@"Key %@ is asked for its hash", [self description]);

    return _hashValue;
}

- (BOOL)isEqual:(BCNastyKey *)object
{
    NSLog(@"Key %@ equality test with %@: %@", [self description], [object description], object == self ? @"YES" : @"NO");

    return object == self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"(&:%p #:%lu)", self, (unsigned long)_hashValue];
}

@end
