//
//  CGPSMapView.h
//  CampusGPS
//
//  Created by Jonathan Baker on 3/21/11.
//  Copyright 2011 Jonathan Baker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CGPSMapViewController : UIViewController {
    @private
	MKMapView * _mapView;
	UIBarButtonItem * _addLocationButton;
}

@property (nonatomic, retain) IBOutlet MKMapView * mapView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem * addLocationButton;

@end
