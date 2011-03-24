//
//  CGPSUniversitySelectionController.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGPSUniversitySelectionController;

@protocol CGPSUniversitySelectionControllerDelegate
@optional
- (void)universitySelectionController:(CGPSUniversitySelectionController *)controller didDismissWithSelection:(id)selectedObject;
@end

@interface CGPSUniversitySelectionController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate> {
	id<CGPSUniversitySelectionControllerDelegate> _delegate;
}

@property (assign) id<CGPSUniversitySelectionControllerDelegate> delegate;

@end
