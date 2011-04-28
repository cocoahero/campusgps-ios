//
//  CGPSCampus.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/24/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CGPSCampus : NSObject 

@property (nonatomic, retain) NSNumber * campusID;
@property (nonatomic, retain) NSString * campusName;
@property (nonatomic, retain) NSString * campusLocation;
@property (nonatomic, retain) NSString * campusWebsite;
@property (nonatomic, retain) NSString * campusDescription;

// Transient Properties
- (NSArray *)locations;
- (MKCoordinateRegion)campusRegion;

// Initializer
- (id)initWithDictionary:(NSDictionary *)dictionary;

// Factory Methods
+ (CGPSCampus *)campus;
+ (CGPSCampus *)campusWithDictionary:(NSDictionary *)dictionary;

@end
