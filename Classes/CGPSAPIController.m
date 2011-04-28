//
//  CGPSAPIController.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/24/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSAPIController.h"
#import "CGPSCampus.h"

void postNotificationOnMainThread(NSString * notifName, id sender) {
	dispatch_async(dispatch_get_main_queue(), ^{
		NSLog(@"Posting %@", notifName);
		[[NSNotificationCenter defaultCenter] postNotificationName:notifName object:sender];
	});
}

@implementation CGPSAPIController

@synthesize operationQueue = _operationQueue;
@synthesize baseResourcePath = _baseResourcePath;
@synthesize campuses = _campuses;
@synthesize locations = _locations;

CHSingleton(CGPSAPIController, sharedAPIController);

#pragma mark - Initializers

- (id)init {
	if((self = [super init])) {
		_operationQueue = [[NSOperationQueue alloc] init];
	}
	return self;
}

#pragma mark - CGPSAPIController Instance Methods

- (void)reloadData {
	[[self operationQueue] addOperationWithBlock:^ {
		NSLog(@"Reloading data...");
		self.campuses = [NSMutableArray arrayWithCapacity:5];
		self.locations = [NSMutableArray arrayWithCapacity:5];
		
		
		ASIHTTPRequest * request = [self requestForObject:[CGPSCampus campus] method:CGPSGetRequest];
		[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/campuses", [self baseResourcePath]]]];
		[request startSynchronous];
		
		if ([request error]) {
			NSLog(@"Error: %@", [request error]);
			abort();
		}
		
		NSArray * campuses = [[request responseData] objectFromJSONData];
		[campuses each:^(id object) {
			NSDictionary * campusDictionary = (NSDictionary *)[object objectForKey:@"campus"];
			[[self campuses] addObject:[CGPSCampus campusWithDictionary:campusDictionary]];
			
			[(NSArray *)[campusDictionary objectForKey:@"locations"] each:^(id object) {
				[[self locations] addObject:[CGPSLocation locationWithDictionary:object]];
			}];
		}];
		
		NSLog(@"Loaded %d Campuses:", [[self campuses] count]);
		[[self campuses] each:^(id campus) {
			NSLog(@"\t%@", [campus description]);
		}];
		NSLog(@"Loaded %d Locations:", [[self locations] count]);
		[[self locations] each:^(id location) {
			NSLog(@"\t%@", [location description]);
		}];
		
		
		NSLog(@"Finished reloading data!");
	}];
}

- (void)saveObject:(id)object {
	[[self operationQueue] addOperationWithBlock:^ {
		if ([object class] == [CGPSCampus class]) {
			CGPSCampus * campus = (CGPSCampus *)object;
			
			if (([campus campusID] == 0 ) || ([campus campusID] == nil)) {
				NSLog(@"Saving new campus...");
				
			}
			else {
				NSLog(@"Updating existing campus...");
			}
			
		}
		else if ([object class] == [CGPSLocation class]) {
			CGPSLocation * location = (CGPSLocation *)object;
			
			if (([location locationID] == 0 ) || ([location locationID] == nil)) {
				NSLog(@"Saving new location...");
				NSData * jsonData = [[location dictionaryRepresentation] JSONData];
				
				ASIHTTPRequest * request = [self requestForObject:location method:CGPSPostRequest];
				[request appendPostData:jsonData];
				[request startSynchronous];
				
				if ([request error]) {
					NSLog(@"Error: %@", [request error]);
					abort();
				}
				
				dispatch_async(dispatch_get_main_queue(), ^{
					[self reloadData];
				});
				
			}
			else {
				NSLog(@"Updating existing location...");
			}
		}
	}];
}

- (ASIHTTPRequest *)requestForObject:(id)object method:(CGPSRequestMethod)method {
	ASIHTTPRequest * request = [[ASIHTTPRequest alloc] init];
	[request addRequestHeader:@"Accept" value:@"application/json"];
	[request addRequestHeader:@"Content-Type" value:@"application/json"];
	
	if ([object class] == [CGPSCampus class]) {
		CGPSCampus * campus = (CGPSCampus *)object;
		
		switch (method) {
			case CGPSGetRequest: {
				[request setRequestMethod:@"GET"];
				NSString * path = [NSString stringWithFormat:@"%@/campuses/%d", [self baseResourcePath], [[campus campusID] intValue]];
				[request setURL:[NSURL URLWithString:path]];
				break;
			}
			case CGPSPostRequest: {
				[request setRequestMethod:@"POST"];
				NSString * path = [NSString stringWithFormat:@"%@/campuses", [self baseResourcePath]];
				[request setURL:[NSURL URLWithString:path]];
				break;
			}
			case CGPSPutRequest: {
				[request setRequestMethod:@"PUT"];
				NSString * path = [NSString stringWithFormat:@"%@/campuses/%d", [self baseResourcePath], [[campus campusID] intValue]];
				[request setURL:[NSURL URLWithString:path]];
				break;
			}
			case CGPSDeleteRequest: {
				[request setRequestMethod:@"DELETE"];
				NSString * path = [NSString stringWithFormat:@"%@/campuses/%d", [self baseResourcePath], [[campus campusID] intValue]];
				[request setURL:[NSURL URLWithString:path]];
				break;
			}
		}
	}
	else if ([object class] == [CGPSLocation class]) {
		CGPSLocation * location = (CGPSLocation *)object;
		
		switch (method) {
			case CGPSGetRequest: {
				[request setRequestMethod:@"GET"];
				NSString * path = [NSString stringWithFormat:@"%@/campuses/%d/locations/%d", [self baseResourcePath], [[location campusID] intValue], [[location locationID] intValue]];
				[request setURL:[NSURL URLWithString:path]];
				break;
			}
			case CGPSPostRequest: {
				[request setRequestMethod:@"POST"];
				NSString * path = [NSString stringWithFormat:@"%@/campuses/%d/locations", [self baseResourcePath], [[location campusID] intValue]];
				[request setURL:[NSURL URLWithString:path]];
				break;
			}
			case CGPSPutRequest: {
				[request setRequestMethod:@"PUT"];
				NSString * path = [NSString stringWithFormat:@"%@/campuses/%d/locations/%d", [self baseResourcePath], [[location campusID] intValue], [[location locationID] intValue]];
				[request setURL:[NSURL URLWithString:path]];
				break;
			}
			case CGPSDeleteRequest: {
				[request setRequestMethod:@"DELETE"];
				NSString * path = [NSString stringWithFormat:@"%@/campuses/%d/locations/%d", [self baseResourcePath], [[location campusID] intValue], [[location locationID] intValue]];
				[request setURL:[NSURL URLWithString:path]];
				break;
			}
		}
	}
	
	return [request autorelease];
}

#pragma mark - ASIHTTPRequestDelegate Protocol Methods



#pragma mark - Memory Management

- (void)dealloc {
	[_campuses release];
	[_locations release];
	[_operationQueue release];
	[_baseResourcePath release];
	
	[super dealloc];
}

@end
