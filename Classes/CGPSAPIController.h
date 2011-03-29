//
//  CGPSAPIController.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/24/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CGPSAPIController : NSObject <RKObjectLoaderDelegate> {
	@private
	RKObjectManager * _objectManager;
}

@property (nonatomic, assign) RKObjectManager * objectManager;

+ (CGPSAPIController *)sharedAPIController;

- (void)loadCampuses;

@end
