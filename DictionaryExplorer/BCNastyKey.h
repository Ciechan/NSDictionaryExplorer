//
//  BCNastyKey.h
//  DictionaryExplorer
//
//  Created by Bartosz Ciechanowski on 07.04.2014.
//  Copyright (c) 2014 Bartosz Ciechanowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCNastyKey : NSObject <NSCopying>

@property (nonatomic, readonly) NSUInteger hashValue;

+ (instancetype)keyWithHashValue:(NSUInteger)hashValue;

@end
