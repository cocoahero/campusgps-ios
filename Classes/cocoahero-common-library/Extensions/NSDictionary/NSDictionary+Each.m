//
//  NSDictionary+Each.m
//  Cocoahero Common Library
//
//  Created by Jonathan Baker on 3/16/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "NSDictionary+Each.h"

@implementation NSDictionary (Each)

- (void)each:(void(^)(id key, id object))block {
	NSArray * allKeys = [self allKeys];
	
	for (int i = 0; i < [allKeys count]; i++) {
		id _key = [allKeys objectAtIndex:i];
		block(_key, [self objectForKey:_key]);
	}
}

@end