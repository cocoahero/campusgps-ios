//
//  CGPSCampusDetailViewController.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/28/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGPSCampus.h"

@interface CGPSCampusDetailViewController : UIViewController {
	@private
	UIBarButtonItem * _mapViewButton;	
	
	UILabel * _campusNameLabel;
	UITextView * _campusDescriptionTextView;
	
	CGPSCampus * _campus;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem * mapViewButton;

@property (nonatomic, retain) IBOutlet UILabel * campusNameLabel;
@property (nonatomic, retain) IBOutlet UITextView * campusDescriptionTextView;

@property (nonatomic, retain) CGPSCampus * campus;

- (id)initWithCampus:(CGPSCampus *)aCampus;
- (IBAction)showMapView;

@end
