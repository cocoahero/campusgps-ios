//
//  CGPSNewLocationViewController.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/28/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSNewLocationViewController.h"
#import "CGPSAPIController.h"

@implementation CGPSNewLocationViewController

@synthesize navigationBar = _navigationBar;
@synthesize locationNameField = _locationNameField;
@synthesize locationDescriptionField = _locationDescriptionField;
@synthesize campus = _campus;

#pragma mark - Initialization

- (id)initWithCampus:(CGPSCampus *)aCampus userLocation:(MKUserLocation *)userLocation {
	if ((self = [super initWithNibName:nil bundle:nil])) {
		self.campus = aCampus;
		_userLocation = [userLocation retain];
		self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-image.jpg"]];
	}
	return self;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[[self navigationController] setNavigationBarHidden:NO animated:animated];
}

#pragma mark - CGPSNewLocationViewController Instance Methods

- (IBAction)cancel:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)done:(id)sender {
	CLLocationCoordinate2D userCoord = [_userLocation coordinate];
	
	if (CLLocationCoordinate2DIsValid(userCoord)) {
		CGPSLocation * newLocation = [CGPSLocation location];
		
		newLocation.campusID = [[self campus] campusID];
		
		newLocation.locationName = [[self locationNameField] text];
		newLocation.locationDescription = [[self locationDescriptionField] text];
		
		newLocation.locationLatitude = [NSNumber numberWithDouble:userCoord.latitude];
		newLocation.locationLongitude = [NSNumber numberWithDouble:userCoord.longitude];
		
		[[CGPSAPIController sharedAPIController] saveObject:newLocation];
		
		[self dismissModalViewControllerAnimated:YES];
	}
	else {
		UIAlertView * alert = [[UIAlertView alloc] init];
		
		alert.title   = @"Where are you??";
		alert.message = @"CampusGPS is unable to get a valid fix on your current location.\n\nThis may be because you are inside a building or you are not allowing CampusGPS to use your current location.";
		[alert addButtonWithTitle:@"Okay"];
		
		[alert show];
		[alert release];
	}	
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[_navigationBar release];
	[_locationNameField release];
	[_locationDescriptionField release];
	[_userLocation release];
	[_campus release];
	
    [super dealloc];
}


@end
