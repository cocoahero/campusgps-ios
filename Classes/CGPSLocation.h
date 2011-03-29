//
//  CGPSLocation.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/25/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import "CGPSCampus.h"

@interface CGPSLocation : RKManagedObject

@property (nonatomic, retain) CGPSCampus * campus;
@property (nonatomic, retain) NSNumber * locationID;
@property (nonatomic, retain) NSString * locationName;
@property (nonatomic, retain) NSString * locationDescription;
@property (nonatomic, retain) NSNumber * locationLongitude;
@property (nonatomic, retain) NSNumber * locationLatitude;
@property (nonatomic, retain) NSNumber * campusID;

@end
