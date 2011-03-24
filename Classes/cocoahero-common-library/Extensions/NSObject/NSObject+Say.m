//
//  NSObject+Say.m
//  Cocoahero Common Library
//
//  Created by Jonathan Baker on 1/31/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "NSObject+Say.h"

@implementation NSObject (Say)

- (void)say:(NSString *)message {
#ifdef DEBUG
    NSLog(@"%@ says, \"%@\"", [self class], message);
#endif
}

@end
