//
//  BCAppDelegate.m
//  DictionaryExplorer
//
//  Created by Bartosz Ciechanowski on 07.04.2014.
//  Copyright (c) 2014 Bartosz Ciechanowski. All rights reserved.
//

#import "BCAppDelegate.h"

#import "BCNastyKey.h"
#import "BC3DIndex.h"

#import "NSDictionary+ExploredDictionary.h"


@implementation BCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Description of internal structures of __NSDictionaryI
    
    NSDictionary *dict = @{@1 : @"Value 1",
                           @2 : @"Value 2",
                           @3 : @"Value 3",
                           @4 : @"Value 4"};
    
    NSLog(@"%@", [dict explored_description]);
    
    
    // Order of keys on enumeration is the same as internal keys order
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"%@ - %@", key, obj);
    }];
    
    
    // Fetching object for nil key returning a result
    
    NSDictionary *indexes = @{[[BC3DIndex alloc] initWithI:2 j:8 k:5] : @"A black hole!",
                              [[BC3DIndex alloc] initWithI:0 j:0 k:0] : @"Asteroids!",
                              [[BC3DIndex alloc] initWithI:4 j:3 k:4] : @"A planet!"};
    
    NSLog(@"Fetching object using a nil key: %@", [indexes objectForKey:nil]);
    
    
    // If the query key has the same address as key inside dictionary, - isEqual: won't be called
    
    
    BCNastyKey *key = [BCNastyKey keyWithHashValue:3];
    NSDictionary *dict2 = @{key : [NSObject new]};
    [dict2 objectForKey:key];
    
    
    // The linear time fetch problem due to extreme abuse of hash
    
    BCNastyKey *targetKey = [BCNastyKey keyWithHashValue:36];
    
    NSDictionary *dict3 = @{[BCNastyKey keyWithHashValue:1] : @1,
                            [BCNastyKey keyWithHashValue:8] : @2,
                            [BCNastyKey keyWithHashValue:15] : @3,
                            [BCNastyKey keyWithHashValue:22] : @4,
                            [BCNastyKey keyWithHashValue:29] : @5,
                            targetKey : @6
                            };
    
    NSLog(@"Querying object");
    NSLog(@"Result: %@", [[dict3 objectForKey:targetKey] description]);
    
    
    
    return YES;
}

@end
