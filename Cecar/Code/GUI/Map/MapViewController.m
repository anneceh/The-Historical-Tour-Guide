//
//  MapViewController.m
//  MobileAR
//
//  Created by Alessandro Boron on 6/17/11.
//
//  Modified by Cecilie Haugstvedt
//  Copyright (c) 2012 NTNU.  
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//  http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
#import "MapViewController.h"
#import "ARController.h"
#import "ARCoordinate.h"
#import "ARMarker.h"
#import "Info.h"
#import "MapButtonView.h"
#import "MapView.h"
#import "MapViewAnnotation.h"

@implementation MapViewController

@synthesize arController;
@synthesize selectedCoordinate;
@synthesize mapView;
@synthesize mapButtonView;
@synthesize userAnnotation;
@synthesize popoverController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    //Initialize the map button
    MapButtonView  *mbv = [[MapButtonView alloc] initWithFrame:CGRectZero];
    self.mapButtonView = mbv;
    self.view = mbv;
    
    //Add action to the map button
    [self.mapButtonView.mapButton addTarget:self action:@selector(mapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Register as observer for the ARController (Location update)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAnnotationsDistanceLabel:) name:@"NSLocationUpdateAnnotations" object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Implemented methods

- (void)setAnnotationForMapView{
    
    //remove all coordinates
    [self.mapView.mapView removeAnnotations:self.mapView.mapView.annotations];
    
    //add the visible coordinates 
    for (ARCoordinate *coordinate in self.arController.coordinates) {
        if ([coordinate isKindOfClass:[ARCoordinate class]]) {
            //Initialize the annotation object with location, title and subtitle
            
            MKPointAnnotation *mva = [[MKPointAnnotation alloc] init];
            mva.coordinate = coordinate.coordinateInformation.location.coordinate;
            mva.title = coordinate.coordinateInformation.title;
            mva.subtitle = [NSString stringWithFormat:@"Avstand: %.0f m",coordinate.coordinateDistance];
            
            //Add the annotation object to the map
            [self.mapView.mapView addAnnotation:mva];
        }
    }
    
    //Set the Annotation for the user location
    MapViewAnnotation  *ua = [[MapViewAnnotation alloc] initWithCoordinate:self.arController.currentLocation.coordinate title:@"Din posisjon" subtitle:nil];
    self.userAnnotation = ua;
    [self.mapView.mapView addAnnotation:ua];    
    
}

- (void)mapButtonPressed:(id)sender{
    //build custom popover view
    UIViewController* popoverContent = [[UIViewController alloc] init];  
    
    //Check if the map view is already initialized, if not enter
    if (mapView == nil) {
        //Initialize the view
        MapView *namv = [[MapView alloc] initWithFrame:CGRectMake(0, 0, 950, 850)];
        self.mapView = namv;
        self.mapView.mapView.delegate = self;
    } 
    
    //Set the POIs of the map
    [self setAnnotationForMapView];
    //Center the region of the map based on the user location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.arController.currentLocation.coordinate, 700, 700);
    self.mapView.mapView.region = region;
    
    
    popoverContent.view = mapView;
    popoverContent.contentSizeForViewInPopover = CGSizeMake(800, 700);
    
    //create a popover controller
    self.popoverController = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
    
    
    //present the popover view non-modal with a
    //refrence to the button pressed within the current view
    [self.popoverController presentPopoverFromRect:mapButtonView.frame
                                            inView:self.arController.overlayView
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:YES];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    //NSLog(@"Map zone Changed");
}

- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)annotation{
    
    static NSString *identifier = @"AnnotationViewIdentifier";
    MKAnnotationView *av = [mv dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (av == nil) {
        av = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    else{
        av.annotation = annotation;
    }
    
    if (![annotation isKindOfClass:[MapViewAnnotation class]]) {
        UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [disclosureButton addTarget:self action:@selector(pinPressedForAnnotation:) forControlEvents:UIControlEventTouchUpInside];
        av.rightCalloutAccessoryView = disclosureButton;
    }
    
    
    
    av.canShowCallout = YES;
    return av;
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
   
    for (ARCoordinate *coordinate in self.arController.coordinates) {
        if ([coordinate isKindOfClass:[ARCoordinate class]]) {
            if (view.annotation.coordinate.latitude == coordinate.coordinateInformation.location.coordinate.latitude) {
                if (view.annotation.coordinate.longitude == coordinate.coordinateInformation.location.coordinate.longitude){
                    selectedCoordinate = coordinate;
                }
            }
        }
    }
}

- (void)pinPressedForAnnotation:(UIButton*)sender{
    if (selectedCoordinate != nil){
        [self.popoverController dismissPopoverAnimated:NO];
        [selectedCoordinate.coordinateMarker showARMarkerDetailsView];
    }
}

#pragma mark - Notification Methods
- (void)updateAnnotationsDistanceLabel:(NSNotification *)notification{
    
    CLLocation *newLocation = [notification object]; 
    
    [self.mapView.mapView removeAnnotation:self.userAnnotation];
    [self.userAnnotation moveAnnotation:newLocation.coordinate];
    [self.mapView.mapView addAnnotation:self.userAnnotation];
    
    for (MKPointAnnotation *annotation in self.mapView.mapView.annotations) {
        if (![annotation isKindOfClass:[MapViewAnnotation class]]) {
            CLLocation *loc = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
            CLLocationDistance distance = [newLocation distanceFromLocation:loc];
            annotation.subtitle = [NSString stringWithFormat:@"Avstand: %.0f m",distance];
        }
    }
}

@end
