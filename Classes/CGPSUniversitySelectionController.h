//
//  CGPSUniversitySelectionController.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGPSCampus.h"

@class CGPSUniversitySelectionController;

@protocol CGPSUniversitySelectionControllerDelegate
@optional
- (void)universitySelectionController:(CGPSUniversitySelectionController *)controller didDismissWithSelection:(CGPSCampus *)selectedCampus;
@end

@interface CGPSUniversitySelectionController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate> {
	@private
	NSArray * _campuses;
	NSPredicate * _searchPredicate;
	
	id<CGPSUniversitySelectionControllerDelegate> _delegate;
}

@property (nonatomic, retain) NSArray * campuses;
@property (nonatomic, retain) NSPredicate * searchPredicate;

@property (assign) id<CGPSUniversitySelectionControllerDelegate> delegate;

@end
