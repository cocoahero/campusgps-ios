//
//  CGPSAppDelegate.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import "CGPSAppDelegate.h"
#import "CGPSWelcomeViewController.h"

@implementation CGPSAppDelegate

@synthesize mainWindow = _mainWindow;

#pragma mark - Initialization

- (id)init {
	if((self = [super init])) {
		UIWindow * aWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		
		self.mainWindow = aWindow;
		
		[aWindow release];
	}
	return self;
}

#pragma mark - UIApplicationDelegate Protocol Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	CGPSWelcomeViewController * welcomeVC = [[CGPSWelcomeViewController alloc] init];
	
	UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:welcomeVC];
		
	[[self mainWindow] setRootViewController:navController];
	
	[navController release];
	[welcomeVC release];
		
	[[self mainWindow] makeKeyAndVisible];
	
    return YES;
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
