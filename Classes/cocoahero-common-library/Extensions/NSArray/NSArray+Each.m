//
//  NSArray+Each.m
//  Cocoahero Common Library
//
//  Created by Jonathan Baker on 3/16/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "NSArray+Each.h"

@implementation NSArray (Each)

- (void)each:(void(^)(id object))block {
	for (int i = 0; i < [self count]; i++) {
		block([self objectAtIndex:i]);
	}
}

@end
