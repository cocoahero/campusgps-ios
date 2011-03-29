//
//  CGPSWelcomeViewController.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSWelcomeViewController.h"
#import "CGPSUniversitySelectionController.h"
#import "CGPSCampusDetailViewController.h"

@implementation CGPSWelcomeViewController

@synthesize welcomeTitleLabel = _welcomeTitleLabel;
@synthesize welcomeDescriptionLabel = _welcomeDescriptionLabel;

#pragma mark - Initialization

- (id)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
		//Do Stuff
    }
    return self;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-image.jpg"]];
	
	self.welcomeTitleLabel.text = @"CampusGPS";
	self.welcomeDescriptionLabel.text = @"Welcome! CampusGPS is your guide around any college campus.\n\nTo begin, tap the button above and find your university's campus.";
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[[self navigationController] setNavigationBarHidden:YES animated:animated];
}

#pragma mark - CGPSWelcomeViewController Methods

- (IBAction)buttonPressed {
	CGPSUniversitySelectionController * universitySelectionVC = [[CGPSUniversitySelectionController alloc] init];
	[universitySelectionVC setDelegate:self];
	
	//[[self navigationController] pushViewController:universitySelectionVC animated:YES];
	[self presentModalViewController:universitySelectionVC animated:YES];
}

#pragma mark - CGPSUniversitySelectionViewControllerDelegate Protocol Methods

- (void)universitySelectionController:(CGPSUniversitySelectionController *)controller didDismissWithSelection:(CGPSCampus *)selectedCampus {
	CGPSCampusDetailViewController * detailVC = [[CGPSCampusDetailViewController alloc] initWithCampus:selectedCampus];
	
	[[self navigationController] pushViewController:detailVC animated:YES];
	
	[detailVC release];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[_welcomeTitleLabel release];
	[_welcomeDescriptionLabel release];
	
    [super dealloc];
}

@end
