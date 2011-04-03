//
//  CGPSMapView.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSMapViewController.h"
#import "CGPSLocation.h"
#import "CGPSNewLocationViewController.h"

@implementation CGPSMapViewController

@synthesize mapView = _mapView;
@synthesize toolbar = _toolbar;

@synthesize campusNameLabel = _campusNameLabel;
@synthesize campusInfoButton = _campusInfoButton;
@synthesize addLocationButton = _addLocationButton;
@synthesize userLocationToggleButton = _userLocationToggleButton;

@synthesize campus = _campus;

#pragma mark - Initialization

- (id)initWithCampus:(CGPSCampus *)aCampus {
	if ((self = [super initWithNibName:nil bundle:nil])) {
		self.hidesBottomBarWhenPushed = NO;
		self.campus = aCampus;
	}
	return self;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setTitle:@"Map View"];
	[[self campusNameLabel] setText:[[self campus] campusName]];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[[self navigationController] setNavigationBarHidden:NO animated:animated];
	[[self mapView] removeAnnotations:[[self mapView] annotations]];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	[self zoomToCampusRegion];
}

#pragma mark - MKMapViewDelegate Protocol Methods

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
	[[self mapView] setCenterCoordinate:[[userLocation location] coordinate] animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[MKUserLocation class]]) {
		return nil;
	}
	
	MKPinAnnotationView * pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[annotation title]];
	if (pinView == nil) {
		pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[annotation title]] autorelease];
	}
	
	pinView.canShowCallout = YES;
	pinView.animatesDrop = YES;
	
	return pinView;
}

#pragma mark - CGPSMapViewController Instance Methods

- (IBAction)showCampusInfo {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showCurrentLocation {
	[[self mapView] setShowsUserLocation:![[self mapView] showsUserLocation]];
	[[self userLocationToggleButton] setTitle:([[self mapView] showsUserLocation]) ? @"Hide Me" : @"Show Me"];
}

- (IBAction)zoomToCampusRegion {
	[[self mapView] setRegion:[[self campus] campusRegion] animated:YES];
	
	[self dropPinsForCampusLocations];
}

- (IBAction)displayNewLocationDialog {
	CGPSNewLocationViewController * newLocationVC = [[CGPSNewLocationViewController alloc] initWithCampus:[self campus] userLocation:[[self mapView] userLocation]];
	
	[self presentModalViewController:newLocationVC animated:YES];
	
	[newLocationVC release];
}

- (IBAction)dropPinsForCampusLocations {
	for (CGPSLocation * location in [[self campus] locations]) {
		MKPointAnnotation * pin = [[MKPointAnnotation alloc] init];
		pin.title = [location locationName];
		pin.coordinate = CLLocationCoordinate2DMake([[location locationLatitude] doubleValue], [[location locationLongitude] doubleValue]);
		[[self mapView] addAnnotation:pin];
		[pin release];
	}
}

#pragma mark - Memory Management

- (void)dealloc {
	[_mapView release];
	[_toolbar release];
	[_campusNameLabel release];
	[_campusInfoButton release];
	[_addLocationButton release];
	[_userLocationToggleButton release];
	[_campus release];
	
    [super dealloc];
}

@end
