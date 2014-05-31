//
//  MapViewController.m
//  museo
//
//  Created by Sergio Romero on 31/05/14.
//  Copyright (c) 2014 uoc. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Intentaremos mostrar la ubicación del usuario.
    //_mapView.showsUserLocation;
}

- (void)viewWillAppear:(BOOL)animated{
    //Definimos las coordenadas de la ubicación del museo para que centre el mapa
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude =41.385194;
    zoomLocation.longitude= 2.180944;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 2000, 2000);
    [_mapView setRegion:viewRegion animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)zoom:(id)sender {
   }

- (IBAction)zoomMapa:(id)sender {
    //Obtenemos las coordenadas del ususario mediante el userLocation
    MKUserLocation *userLocation = _mapView.userLocation;
    //Según las coordenadas obtenidas definimos una región para mostrar, en este caso 20000 metros
    MKCoordinateRegion region =MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 20000, 20000);
    //Mostramos la región en el mapa
    [_mapView setRegion:region animated:NO];
    
}

- (IBAction)tipoMapa:(id)sender {
    //Cada vez que pulsemos alternaremos entre los tipos de mapa Satellite o Standard
    if (_mapView.mapType == MKMapTypeStandard)
        _mapView.mapType = MKMapTypeSatellite;
    else
        _mapView.mapType = MKMapTypeStandard;
}
@end
