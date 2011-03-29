//
//  CGPSCampusDetailViewController.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/28/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSCampusDetailViewController.h"
#import "CGPSMapViewController.h"


@implementation CGPSCampusDetailViewController

@synthesize mapViewButton = _mapViewButton;

@synthesize campusNameLabel = _campusNameLabel;
@synthesize campusDescriptionTextView = _campusDescriptionTextView;

@synthesize campus = _campus;

#pragma mark - Initialization

- (id)initWithCampus:(CGPSCampus *)aCampus {
	if ((self = [super initWithNibName:nil bundle:nil])) {
		self.campus = aCampus;
		self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-image.jpg"]];
	}
	return self;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setTitle:@"Campus Info"];
	[[self navigationItem] setRightBarButtonItem:[self mapViewButton]];
	[[self campusNameLabel] setText:[[self campus] campusName]];
	[[self campusDescriptionTextView] setText:[[self campus] campusDescription]];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[[self navigationController] setNavigationBarHidden:NO animated:animated];
}

#pragma mark - CGPSCampusDetailViewController Instance Methods

- (IBAction)showMapView {
	CGPSMapViewController * mapVC = [[CGPSMapViewController alloc] initWithCampus:[self campus]];
	[mapVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self presentModalViewController:mapVC animated:YES];
	[mapVC release];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[_mapViewButton release];
	[_campusNameLabel release];
	[_campusDescriptionTextView release];
	[_campus release];
	
    [super dealloc];
}


@end
