//
//  CGPSAppDelegate.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

#import "CGPSAppDelegate.h"
#import "CGPSAPIController.h"
#import "CGPSCampus.h"
#import "CGPSLocation.h"
#import "CGPSWelcomeViewController.h"

@interface CGPSAppDelegate (Private)
- (void)initMainWindow;
- (void)initRestKit;
- (void)buildViewHierarchy;
@end

@implementation CGPSAppDelegate

@synthesize mainWindow = _mainWindow;

#pragma mark - UIApplicationDelegate Protocol Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self initMainWindow];
	[self initRestKit];
	[self buildViewHierarchy];
	
	[[self mainWindow] makeKeyAndVisible];
	
	[[CGPSAPIController sharedAPIController] loadCampuses];
	
    return YES;
}

#pragma mark - CGPSAppDelegate (Private) Methods

- (void)initMainWindow {
	UIWindow * aWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	self.mainWindow = aWindow;
	
	[aWindow release];
}

- (void)initRestKit {
	RKObjectManager * objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://localhost:3000"];
	
	[objectManager setObjectStore:[[[RKManagedObjectStore alloc] initWithStoreFilename:@"CampusGPS.sqlite"] autorelease]];
	
	[[objectManager mapper] setMissingElementMappingPolicy:RKSetNilForMissingElementMappingPolicy];
	
	[[objectManager mapper] registerClass:[CGPSCampus class] forElementNamed:@"campus"];
	[[objectManager mapper] registerClass:[CGPSLocation class] forElementNamed:@"location"];
	[[objectManager mapper] registerClass:[CGPSLocation class] forElementNamed:@"locations"];
	
	RKDynamicRouter * router = (RKDynamicRouter *)[objectManager router];
	
	[router routeClass:[CGPSCampus class] toResourcePath:@"/campuses/(campusID)"];
	[router routeClass:[CGPSCampus class] toResourcePath:@"/campuses" forMethod:RKRequestMethodPOST];
	[router routeClass:[CGPSLocation class] toResourcePath:@"/campuses/(campusID)/locations/(locationID)"];
	[router routeClass:[CGPSLocation class] toResourcePath:@"/campuses/(campusID)/locations" forMethod:RKRequestMethodPOST];
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
