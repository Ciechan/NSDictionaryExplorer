//
//  NSDictionary+ExploredDictionary.h
//  DictionaryExplorer
//
//  Created by Bartosz Ciechanowski on 07.04.2014.
//  Copyright (c) 2014 Bartosz Ciechanowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ExploredDictionary)

- (NSString *)explored_description;
- (id)explored_objectForKey:(id)aKey;

@end
