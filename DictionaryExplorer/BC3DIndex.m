//
//  BC3DIndex.m
//  DictionaryExplorer
//
//  Created by Bartosz Ciechanowski on 07.04.2014.
//  Copyright (c) 2014 Bartosz Ciechanowski. All rights reserved.
//

#import "BC3DIndex.h"

@implementation BC3DIndex

- (instancetype)initWithI:(NSUInteger)i j:(NSUInteger)j k:(NSUInteger)k
{
    self = [super init];
    if (self) {
        _i = i;
        _j = j;
        _k = k;
    }
    return self;
}

- (BOOL)isEqual:(BC3DIndex *)other
{
    // This implementation is the culprit of nil fetch problem
    // It should check whether the other object is nil
    
    return other.i == _i && other.j == _j && other.k == _k;
}

- (NSUInteger)hash
{
    return _i ^ _j ^ _k;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self; // we're immutable so it's OK
}

@end
