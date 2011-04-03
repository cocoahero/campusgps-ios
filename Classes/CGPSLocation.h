//
//  CGPSLocation.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/25/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGPSCampus.h"

@interface CGPSLocation : NSObject

@property (nonatomic, retain) NSNumber * locationID;
@property (nonatomic, retain) NSString * locationName;
@property (nonatomic, retain) NSString * locationDescription;
@property (nonatomic, retain) NSNumber * locationLongitude;
@property (nonatomic, retain) NSNumber * locationLatitude;
@property (nonatomic, retain) NSNumber * campusID;

+ (CGPSLocation *)location;
+ (CGPSLocation *)locationWithDictionary:(NSDictionary *)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
