//
//  CGPSCampus.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/24/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

@interface CGPSCampus : RKManagedObject

@property (nonatomic, retain) NSNumber * campusID;
@property (nonatomic, retain) NSString * campusName;
@property (nonatomic, retain) NSString * campusDescription;
@property (nonatomic, retain) NSSet * locations;

// Transient Properties
- (MKCoordinateRegion)campusRegion;

@end
