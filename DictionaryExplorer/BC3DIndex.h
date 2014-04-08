//
//  BC3DIndex.h
//  DictionaryExplorer
//
//  Created by Bartosz Ciechanowski on 07.04.2014.
//  Copyright (c) 2014 Bartosz Ciechanowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BC3DIndex : NSObject <NSCopying>

@property (nonatomic, readonly) NSUInteger i, j, k; // you actually can do that

- (instancetype)initWithI:(NSUInteger)i j:(NSUInteger)j k:(NSUInteger)k;

@end
