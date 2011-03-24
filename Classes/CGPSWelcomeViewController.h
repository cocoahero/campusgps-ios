//
//  CGPSWelcomeViewController.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGPSUniversitySelectionController.h"

@interface CGPSWelcomeViewController : UIViewController <CGPSUniversitySelectionControllerDelegate> {
    @private
	UILabel * _welcomeTitleLabel;
	UILabel * _welcomeDescriptionLabel;
}

@property (nonatomic, retain) IBOutlet UILabel * welcomeTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel * welcomeDescriptionLabel;

- (IBAction)buttonPressed;

@end
