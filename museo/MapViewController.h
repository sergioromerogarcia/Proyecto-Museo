//
//  MapViewController.h
//  museo
//
//  Created by Sergio Romero on 31/05/14.
//  Copyright (c) 2014 uoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)zoomMapa:(id)sender;
- (IBAction)tipoMapa:(id)sender;

@end
