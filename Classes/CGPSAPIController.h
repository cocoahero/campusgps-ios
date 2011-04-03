//
//  CGPSAPIController.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/24/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGPSCampus.h"
#import "CGPSLocation.h"

typedef enum {
	CGPSPostRequest = 1,
	CGPSGetRequest,
	CGPSPutRequest,
	CGPSDeleteRequest
} CGPSRequestMethod;

@interface CGPSAPIController : NSObject <ASIHTTPRequestDelegate> {
	@private
	NSOperationQueue * _operationQueue;
	
	NSString * _baseResourcePath;
	
	NSMutableArray * _campuses;
	NSMutableArray * _locations;
}

@property (readonly) NSOperationQueue * operationQueue;

@property (retain) NSString * baseResourcePath;

@property (retain) NSMutableArray * campuses;
@property (retain) NSMutableArray * locations;

+ (CGPSAPIController *)sharedAPIController;

- (ASIHTTPRequest *)requestForObject:(id)object method:(CGPSRequestMethod)method;

- (void)reloadData;
- (void)saveObject:(id)object;

@end
