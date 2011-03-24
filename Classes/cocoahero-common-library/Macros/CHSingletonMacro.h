//
//  CHSingletonMacro.h
//  cocoahero-common-library-tester
//
//  Created by Jonathan Baker on 3/18/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#define CHSingleton(classname, accessorName) \
\
static classname * shared##classname = nil; \
\
+ (classname *)accessorName \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\
- (id)retain \
{ \
return self; \
} \
\
- (NSUInteger)retainCount \
{ \
return NSUIntegerMax; \
} \
\
- (void)release \
{ \
} \
\
- (id)autorelease \
{ \
return self; \
}
