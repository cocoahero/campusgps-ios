//
//  CGPSUniversitySelectionController.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSUniversitySelectionController.h"
#import "CGPSCampus.h"
#import "CGPSMapViewController.h"

@implementation CGPSUniversitySelectionController

@synthesize delegate = _delegate;
@synthesize campuses = _campuses;
@synthesize searchPredicate = _searchPredicate;

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

- (void)viewWillAppear:(BOOL)animated {
	[self setCampuses:nil];
}

- (void)viewDidAppear:(BOOL)animated {
	[self.searchDisplayController.searchBar becomeFirstResponder];
}

#pragma mark - UITableViewDelegate Protocol Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self dismissModalViewControllerAnimated:YES];
	[[self delegate] universitySelectionController:self didDismissWithSelection:[[self campuses] objectAtIndex:indexPath.row]];
}

#pragma mark - UITableViewDataSource Protocol Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString * campusSelectionCellIdentifier = @"CGPSUniversitySelectionControllerTableViewCellIdentifier";
	
	UITableViewCell * cell;
	
	if (!(cell = [tableView dequeueReusableCellWithIdentifier:campusSelectionCellIdentifier])) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:campusSelectionCellIdentifier] autorelease];
	}
	
	CGPSCampus * campus = (CGPSCampus *)[[self campuses] objectAtIndex:indexPath.row];
	
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.textLabel.text = [campus campusName];
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self campuses] count];
}

#pragma mark - UISearchDisplayControllerDelegate Protocol Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {	
	self.searchPredicate = nil;
	self.searchPredicate = [NSPredicate predicateWithFormat:@"campusName CONTAINS[cd] %@", searchString];
	
	[self setCampuses:nil];
	
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Properties

- (NSArray *)campuses {
	if (_campuses != nil) {
		return _campuses;
	}
	
	NSFetchRequest * fetchRequest = [CGPSCampus fetchRequest];
	
	NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"campusName" ascending:YES];
	
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	[fetchRequest setPredicate:[self searchPredicate]];
	
	_campuses = [[CGPSCampus objectsWithFetchRequest:fetchRequest] retain];
	
	return _campuses;
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {	
	[_campuses release];
	[_searchPredicate release];
	
    [super dealloc];
}

@end
