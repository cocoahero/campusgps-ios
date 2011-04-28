//
//  CGPSCampus.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/24/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSCampus.h"
#import "CGPSLocation.h"
#import "CGPSAPIController.h"

@implementation CGPSCampus

@synthesize campusID;
@synthesize campusName;
@synthesize campusLocation;
@synthesize campusWebsite;
@synthesize campusDescription;

#pragma mark - CGPSCampus Factory Methods

+ (CGPSCampus *)campus {
	return [[[CGPSCampus alloc] initWithDictionary:nil] autorelease];
}

+ (CGPSCampus *)campusWithDictionary:(NSDictionary *)dictionary {
	return [[[CGPSCampus alloc] initWithDictionary:dictionary] autorelease];
}

#pragma mark - Initializer

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if ((self = [super init])) {
		if (dictionary != nil) {
			self.campusID = [dictionary objectForKey:@"id"];
			self.campusName = [dictionary objectForKey:@"name"];
			self.campusLocation = [dictionary objectForKey:@"location"];
			self.campusWebsite = [dictionary objectForKey:@"website"];
			self.campusDescription = [dictionary objectForKey:@"description"];
		}
	}
	return self;
}

#pragma mark - CGPSCampus Instance Methods

- (NSString *)description {
	return [NSString stringWithFormat:@"%@", [self campusName]];
}

- (NSArray *)locations {
	NSPredicate * predicate = [NSPredicate predicateWithFormat:@"campusID == %d", [[self campusID] intValue]];
	return [[[CGPSAPIController sharedAPIController] locations] filteredArrayUsingPredicate:predicate];
}

- (MKCoordinateRegion)campusRegion {
	double minLat = CGFLOAT_MAX;
	double minLong = CGFLOAT_MAX;
	double maxLat = (CGFLOAT_MAX * -1.0);
	double maxLong = (CGFLOAT_MAX * -1.0);
	int locationCount = 0;
	
	for (CGPSLocation * location in [self locations]) {
		//NSLog(@"%@: %f, %f", [location locationName], [[location locationLatitude] doubleValue], [[location locationLongitude] doubleValue]);
		locationCount++;
		
		if ([[location locationLatitude] doubleValue] < minLat) {
			minLat = [[location locationLatitude] doubleValue];
		}
		if ([[location locationLatitude] doubleValue] > maxLat) {
			maxLat = [[location locationLatitude] doubleValue];
		}
		if ([[location locationLongitude] doubleValue] < minLong) {
			minLong = [[location locationLongitude] doubleValue];
		}
		if ([[location locationLongitude] doubleValue] > maxLong) {
			maxLong = [[location locationLongitude] doubleValue];
		}
	}
	
	//NSLog(@"Min Latitude: %f", minLat);
	//NSLog(@"Max Latitude: %f", maxLat);
	//NSLog(@"Min Longitude: %f", minLong);
	//NSLog(@"Max Longitude: %f", maxLong);
	
	double centerLat = (locationCount == 1) ? minLat: (((maxLat - minLat) / 2.0) + minLat);
	double centerLong = (locationCount == 1) ? minLong: (((maxLong - minLong) / 2.0) + minLong);
	
	//NSLog(@"Center Point: %f, %f", centerLat, centerLong);
	
	MKCoordinateSpan span = MKCoordinateSpanMake(MAX(fabs(maxLat - minLat), 0.005), MAX(fabs(maxLong - minLong), 0.005));
	CLLocationCoordinate2D center = CLLocationCoordinate2DMake(centerLat, centerLong);
	
	return MKCoordinateRegionMake(center, span);
}

@end
