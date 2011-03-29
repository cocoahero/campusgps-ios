//
//  CGPSMapView.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CGPSCampus.h"

@interface CGPSMapViewController : UIViewController <MKMapViewDelegate> {
    @private
	MKMapView * _mapView;
	UIToolbar * _toolbar;
	
	UILabel * _campusNameLabel;
	UIBarButtonItem * _campusInfoButton;
	UIBarButtonItem * _addLocationButton;
	
	CGPSCampus * _campus;
}

@property (nonatomic, retain) IBOutlet MKMapView * mapView;
@property (nonatomic, retain) IBOutlet UIToolbar * toolbar;

@property (nonatomic, retain) IBOutlet UILabel * campusNameLabel;
@property (nonatomic, retain) IBOutlet UIBarButtonItem * campusInfoButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem * addLocationButton;

@property (nonatomic, retain) CGPSCampus * campus;

- (id)initWithCampus:(CGPSCampus *)aCampus;

- (IBAction)showCampusInfo;
- (IBAction)showCurrentLocation;
- (IBAction)zoomToCampusRegion;
- (IBAction)dropPinsForCampusLocations;
- (IBAction)displayNewLocationDialog;

@end
