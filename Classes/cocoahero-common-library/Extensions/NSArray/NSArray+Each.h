//
//  NSArray+Each.h
//  Cocoahero Common Library
//
//  Created by Jonathan Baker on 3/16/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Each)

- (void)each:(void(^)(id object))block;

@end
