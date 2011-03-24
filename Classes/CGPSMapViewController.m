//
//  CGPSMapView.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSMapViewController.h"


@implementation CGPSMapViewController

@synthesize mapView = _mapView;
@synthesize addLocationButton = _addLocationButton;

#pragma mark - Initialization

- (id)init {
	if ((self = [super initWithNibName:nil bundle:nil])) {
		self.hidesBottomBarWhenPushed = NO;
	}
	return self;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
	[super viewDidLoad];
		
	[[self navigationItem] setRightBarButtonItem:[self addLocationButton]];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[[self navigationController] setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Memory Management

- (void)dealloc {
	[_mapView release];
	[_addLocationButton release];
	
    [super dealloc];
}

@end
