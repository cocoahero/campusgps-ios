//
//  CGPSUniversitySelectionController.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSUniversitySelectionController.h"
#import "CGPSMapViewController.h"

@implementation CGPSUniversitySelectionController

@synthesize delegate = _delegate;

#pragma mark - Initialization

- (id)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"Choose University";
    }
    return self;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-image.jpg"]];
}

- (void)viewDidAppear:(BOOL)animated {
	[self.searchDisplayController.searchBar becomeFirstResponder];
}

#pragma mark - UITableViewDelegate Protocol Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self dismissModalViewControllerAnimated:YES];
	[[self delegate] universitySelectionController:self didDismissWithSelection:nil];
}

#pragma mark - UITableViewDataSource Protocol Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell * cell;
	
	if (!(cell = [tableView dequeueReusableCellWithIdentifier:@"BLANK"])) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BLANK"] autorelease];
	}
	
	cell.textLabel.text = @"Table View Cell";
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

#pragma mark - UISearchDisplayControllerDelegate Protocol Methods

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}

@end
