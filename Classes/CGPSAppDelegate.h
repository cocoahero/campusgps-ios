//
//  CGPSAppDelegate.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGPSAppDelegate : NSObject <UIApplicationDelegate> {
	@private
	UIWindow * _mainWindow;
}

@property (nonatomic, retain) UIWindow * mainWindow;

+ (NSURL *)applicationDocumentsDirectory;

+ (CGPSAppDelegate *)sharedApplicationDelegate;

@end
