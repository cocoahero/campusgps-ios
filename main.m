//
//  main.m
//  CampusGPS
//
//  Created by Jonathan Baker on 3/24/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"CGPSAppDelegate");
    [pool release];
    return retVal;
}
