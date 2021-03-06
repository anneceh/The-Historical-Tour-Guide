//
//  MapViewController.h
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

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class ARController;
@class ARCoordinate;
@class MapButtonView;
@class MapView;
@class MapViewAnnotation;

@interface MapViewController : UIViewController <MKMapViewDelegate> {
    ARController *arController;
    ARCoordinate *selectedCordinate;
    MapButtonView *mapButtonView;
    MapView *mapView;
    MapViewAnnotation *userAnnotation;
    UIPopoverController *popoverController;
}

@property (nonatomic, retain) ARController *arController;
@property (nonatomic, retain) ARCoordinate *selectedCoordinate; //to find associated disclosure when clicking on annotation
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) MapButtonView *mapButtonView;  
@property (nonatomic, retain) MapView *mapView;     
@property (nonatomic, retain) MapViewAnnotation *userAnnotation;

- (void)mapButtonPressed:(id)sender;
- (void)setAnnotationForMapView;

@end
