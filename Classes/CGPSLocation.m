//
//  CGPSLocation.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/25/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSLocation.h"

@implementation CGPSLocation

@synthesize locationID;
@synthesize locationName;
@synthesize locationDescription;
@synthesize locationLongitude;
@synthesize locationLatitude;
@synthesize campusID;

+ (CGPSLocation *)location {
	return [[[CGPSLocation alloc] initWithDictionary:nil] autorelease];
}

+ (CGPSLocation *)locationWithDictionary:(NSDictionary *)dictionary {
	return [[[CGPSLocation alloc] initWithDictionary:dictionary] autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if ((self = [super init])) {
		if (dictionary != nil) {
			self.locationID = [dictionary objectForKey:@"id"];
			self.locationName = [dictionary objectForKey:@"name"];
			self.locationDescription = [dictionary objectForKey:@"description"];
			self.locationLatitude = [dictionary objectForKey:@"latitude"];
			self.locationLongitude = [dictionary objectForKey:@"longitude"];
			self.campusID = [dictionary objectForKey:@"campus_id"];
		}
	}
	return self;
}

- (NSDictionary *)dictionaryRepresentation {
	NSMutableDictionary * properties = [NSMutableDictionary dictionaryWithCapacity:6];
	[properties setObject:[self valueForKey:@"locationID"] forKey:@"id"];
	[properties setObject:self.locationName forKey:@"name"];
	[properties setObject:self.locationDescription forKey:@"description"];
	[properties setObject:self.locationLatitude forKey:@"latitude"];
	[properties setObject:self.locationLongitude forKey:@"longitude"];
	[properties setObject:self.campusID forKey:@"campus_id"];
	
	return [NSDictionary dictionaryWithObject:properties forKey:@"location"];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ (%f , %f)", [self locationName], [[self locationLatitude] doubleValue], [[self locationLongitude] doubleValue]];
}

- (id)valueForKey:(NSString *)key {
	id value = [super valueForKey:key];
	if (value != nil) {
		return value;
	}
	return [NSNull null];
}

- (id)valueForUndefinedKey:(NSString *)key {
	return [NSNull null];
}

@end
