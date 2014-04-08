//
//  NSDictionary+ExploredDictionary.m
//  DictionaryExplorer
//
//  Created by Bartosz Ciechanowski on 07.04.2014.
//  Copyright (c) 2014 Bartosz Ciechanowski. All rights reserved.
//

#import "NSDictionary+ExploredDictionary.h"

NSUInteger *Explored__NSDictionarySizes;

@interface BCExploredDictionary : NSDictionary
{
@public
    
#if defined(__arm64__)
    NSUInteger _used:58;
    NSUInteger _szidx:6;
    
#elif defined(__arm__)
    NSUInteger _used:26;
    NSUInteger _szidx:6;
#endif

}
@end

@implementation BCExploredDictionary
@end

@implementation NSDictionary (ExploredDictionary)

+ (void)load
{
    // This works on both iOS 7.0 and iOS 7.1, will probably break in the future
    Explored__NSDictionarySizes = (NSUInteger *)((char *)&kCFAbsoluteTimeIntervalSince1904 + 8);
}

- (NSString *)explored_description
{
    assert([NSStringFromClass([self class]) isEqualToString:@"__NSDictionaryI"]);
    
    BCExploredDictionary *dict = (BCExploredDictionary *)self;

    NSUInteger count = dict->_used;
    NSUInteger sizeIndex = dict->_szidx;
    NSUInteger size = Explored__NSDictionarySizes[sizeIndex];
    
    __unsafe_unretained id *storage = (__unsafe_unretained id *)object_getIndexedIvars(dict);
    
    NSMutableString *description = [NSMutableString stringWithString:@"\n"];
    
    [description appendFormat:@"Count: %lu\n", (unsigned long)count];
    [description appendFormat:@"Size index: %lu\n", (unsigned long)sizeIndex];
    [description appendFormat:@"Size: %lu\n", (unsigned long)size];

    for (int i = 0; i < size; i++) {
        [description appendFormat:@"[%d] %@ - %@\n", i, [storage[2*i] description], [storage[2*i + 1] description]];
    }
    
    return description;
}

- (id)explored_objectForKey:(id)aKey
{
    assert([NSStringFromClass([self class]) isEqualToString:@"__NSDictionaryI"]);

    BCExploredDictionary *dict = (BCExploredDictionary *)self;
    
    NSUInteger sizeIndex = dict->_szidx;
    NSUInteger size = Explored__NSDictionarySizes[sizeIndex];
    
    __unsafe_unretained id *storage = (__unsafe_unretained id *)object_getIndexedIvars(dict);
    
    NSUInteger fetchIndex = [aKey hash] % size;
    
    for (int i = 0; i < size; i++) {
        __unsafe_unretained id queriedKey = storage[2 * fetchIndex];

        if (queriedKey == nil) {
            return nil;
        }
        
        if (queriedKey == aKey || [queriedKey isEqual:aKey]) {
            return storage[2 * fetchIndex + 1];
        }

        fetchIndex++;
        
        if (fetchIndex == size) {
            fetchIndex = 0;
        }
    }
    
    return nil;
}

@end
