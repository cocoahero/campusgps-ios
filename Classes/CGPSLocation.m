//
//  CGPSLocation.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/25/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSLocation.h"


@implementation CGPSLocation

@dynamic locationID;
@dynamic locationName;
@dynamic locationDescription;
@dynamic locationLongitude;
@dynamic locationLatitude;
@dynamic campusID;
@dynamic campus;

+ (NSDictionary *)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"locationID",
			@"name", @"locationName",
			@"description", @"locationDescription",
			@"longitude", @"locationLongitude",
			@"latitude", @"locationLatitude",
			@"campus_id", @"campusID",
			nil];
}

+ (NSString *)primaryKeyProperty {
	return @"locationID";
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ (%d , %d)", [self locationName], [[self locationLongitude] intValue], [[self locationLatitude] intValue]];
}


@end
