//
//  CGPSAppDelegate.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSAppDelegate.h"
#import "CGPSAPIController.h"
#import "CGPSCampus.h"
#import "CGPSLocation.h"
#import "CGPSWelcomeViewController.h"

@interface CGPSAppDelegate (Private)
- (void)initMainWindow;
- (void)configureAPIController;
- (void)buildViewHierarchy;
@end

@implementation CGPSAppDelegate

@synthesize mainWindow = _mainWindow;

#pragma mark - UIApplicationDelegate Protocol Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self initMainWindow];
	[self configureAPIController];
	[self buildViewHierarchy];
	
	[[self mainWindow] makeKeyAndVisible];
	
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CGPSAPIController sharedAPIController] reloadData];
}

#pragma mark - CGPSAppDelegate (Private) Methods

- (void)initMainWindow {
	UIWindow * aWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	self.mainWindow = aWindow;
	
	[aWindow release];
}

- (void)configureAPIController {
	[[CGPSAPIController sharedAPIController] setBaseResourcePath:@"http://campusgps.heroku.com"];
}

- (void)buildViewHierarchy {
	CGPSWelcomeViewController * welcomeVC = [[CGPSWelcomeViewController alloc] init];
	
	UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:welcomeVC];
	
	[[self mainWindow] setRootViewController:navController];
	
	[navController release];
	[welcomeVC release];	
}

#pragma mark - CGPSAppDelegate Class Methods

+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (CGPSAppDelegate *)sharedApplicationDelegate {
	return (CGPSAppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - Memory Management

- (void)dealloc {
	[_mainWindow release];

    [super dealloc];
}

@end
