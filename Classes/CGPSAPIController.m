//
//  CGPSAPIController.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/24/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSAPIController.h"
#import "CGPSCampus.h"

@implementation CGPSAPIController

@synthesize objectManager = _objectManager;

CHSingleton(CGPSAPIController, sharedAPIController);

#pragma mark - Initializers

- (id)init {
	if((self = [super init])) {
		self.objectManager = [RKObjectManager sharedManager];
	}
	return self;
}

#pragma mark - CGPSAPIController Instance Methods

- (void)loadCampuses {
	[[self objectManager] loadObjectsAtResourcePath:@"/campuses.json" delegate:self];
}

#pragma mark - RKObjectLoaderDelegate Protocol Methods

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
	NSLog(@"Loaded %d campuses", [objects count]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
	NSLog(@"Error: %@ - %@", [error code], [error localizedDescription]);
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - Memory Management

- (void)dealloc {
	[super dealloc];
}

@end
