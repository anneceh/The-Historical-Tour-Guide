//
//  ARController.h
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

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class ARCoordinate;

@interface ARController : NSObject <UIAccelerometerDelegate, CLLocationManagerDelegate> {
 
    UIViewController *rootViewController; 
    UIImagePickerController *cameraController;
    UIView *overlayView;
    
    CLLocationManager *locationManager;
    UIAccelerometer *accelerometer;
    
    UIDeviceOrientation currentOrientation; 
    double viewRange;
    
    CLLocation *currentLocation; 
    CLHeading *currentHeading;
    
    ARCoordinate *currentCoordinate;
    double viewAngle;
    
    NSMutableArray *coordinates;                                               
    NSMutableArray *coordinatesNotVisualized;
    
}

@property (nonatomic, retain) UIViewController *rootViewController; 
@property (nonatomic, retain) UIImagePickerController *cameraController;
@property (nonatomic, retain) UIView *overlayView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UIAccelerometer *accelerometer;
@property (nonatomic) UIDeviceOrientation currentOrientation; 
@property (nonatomic) double viewRange;
@property (nonatomic) double viewAngle;
@property (nonatomic, retain) CLLocation *currentLocation; 
@property (nonatomic, retain) CLHeading *currentHeading;
@property (nonatomic, retain) ARCoordinate *currentCoordinate;
@property (nonatomic, retain) NSMutableArray *coordinates;                                               
@property (nonatomic, retain) NSMutableArray *coordinatesNotVisualized;

// Designated initializer
- (id)initWithViewController:(UIViewController *)viewController;

// Presents the camera view
- (void)presentCameraAnimated:(BOOL) animated;

// Adds a coordinate (POI) to the array of visible coordinates
- (void)addCoordinate:(ARCoordinate *)coordinate animated:(BOOL)animated; 

// Removes a coordinate (POI) from the array of visible coordinates
- (void)removeCoordinate:(ARCoordinate *)coordinate animated:(BOOL)animated;

- (void)updateCurrentCoordinate; 
- (void)updateCurrentLocation:(CLLocation *)newLocation; 
- (void)updateClosestPointsHeading:(NSNumber *)heading;
- (void)updateMapAnnotations:(CLLocation *)coordinate;


@end
