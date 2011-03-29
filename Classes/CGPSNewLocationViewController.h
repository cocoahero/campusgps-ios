//
//  CGPSNewLocationViewController.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/28/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import "CGPSCampus.h"
#import "CGPSLocation.h"

@interface CGPSNewLocationViewController : UIViewController <RKObjectLoaderDelegate> {
	@private
	UINavigationBar * _navigationBar;
	
	UITextField * _locationNameField;
	UITextView * _locationDescriptionField;
	
	MKUserLocation * _userLocation;
	CGPSCampus * _campus;
}

@property (nonatomic, retain) UINavigationBar * navigationBar;
@property (nonatomic, retain) IBOutlet UITextField * locationNameField;
@property (nonatomic, retain) IBOutlet UITextView * locationDescriptionField;
@property (nonatomic, retain) CGPSCampus * campus;

- (id)initWithCampus:(CGPSCampus *)aCampus userLocation:(MKUserLocation *)userLocation;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
