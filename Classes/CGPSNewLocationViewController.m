//
//  CGPSNewLocationViewController.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/28/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSNewLocationViewController.h"


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
	CGPSLocation * newLocation = [CGPSLocation object];
	
	newLocation.campusID = [[self campus] campusID];
	
	newLocation.locationName = [[self locationNameField] text];
	newLocation.locationDescription = [[self locationDescriptionField] text];
	
	CLLocationCoordinate2D userCoord = [_userLocation coordinate];
	
	newLocation.locationLatitude = [NSNumber numberWithDouble:userCoord.latitude];
	newLocation.locationLongitude = [NSNumber numberWithDouble:userCoord.longitude];
	
	//[newLocation setCampus:[self campus]];
			
	[[RKObjectManager sharedManager] postObject:newLocation delegate:self];
	
	[self dismissModalViewControllerAnimated:YES];
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader {
	NSLog(@"SOMETHING HAPPENED UNEXPECTEDLY!");
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
	NSLog(@"MY ERROR: %@", error);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
	NSLog(@"LOADED %d OBJECTS", [objects count]);
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
