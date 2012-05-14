//
//  ARController.m
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

#import "ARController.h"
#import "ARCoordinate.h"
#import "ARGeoCoordinate.h"
#import "ARMarker.h"
#import "ARMarkerDetailsView.h"

@implementation ARController

@synthesize rootViewController; 
@synthesize cameraController;
@synthesize overlayView;
@synthesize locationManager;
@synthesize accelerometer;
@synthesize currentOrientation; 
@synthesize viewRange;
@synthesize currentLocation; 
@synthesize currentHeading;
@synthesize currentCoordinate;
@synthesize viewAngle;
@synthesize coordinates;                                               
@synthesize coordinatesNotVisualized;

- (id)initWithViewController:(UIViewController *)viewController {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        self.rootViewController = viewController; 
        
        //Retrieve screen bounds
        CGRect screenBounds = [[UIScreen mainScreen] bounds]; 
        
        UIView *overlaidView = [[UIView alloc] initWithFrame: screenBounds];
        self.overlayView =  overlaidView;
        self.rootViewController.view = overlayView;
        
        // Initialise the UIImagePickerController (camera)
        UIImagePickerController *picker= [[UIImagePickerController alloc] init];
        self.cameraController = picker;
        
        self.cameraController.sourceType = UIImagePickerControllerSourceTypeCamera; 
        self.cameraController.cameraViewTransform = CGAffineTransformScale(self.cameraController.cameraViewTransform, 1.0f, 1.12412f);
        self.cameraController.showsCameraControls = NO; 
        self.cameraController.navigationBarHidden = YES; 
        self.cameraController.cameraOverlayView = overlayView;
        
        // Initialise the CLLocationManager
        CLLocationManager *clManager = [[CLLocationManager alloc] init]; 
        self.locationManager = clManager;
        self.locationManager.headingFilter = kCLHeadingFilterNone; 
        self.locationManager.headingOrientation = CLDeviceOrientationLandscapeLeft;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
        self.locationManager.delegate = self; 
        
        //Start to capture heading and location changes
        [self.locationManager startUpdatingHeading]; 
        [self.locationManager startUpdatingLocation];
        
        // Initalise the UIAccelerometer
        self.accelerometer = [UIAccelerometer sharedAccelerometer]; 
        self.accelerometer.updateInterval = 0.25; 
        self.accelerometer.delegate = self;
        
        // Listen for changes in device orientation
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object:nil];
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
        //Set the initial (current) location
        CLLocation *cLocation = [[CLLocation alloc] initWithLatitude:37.33231 longitude:- 122.03118];
        self.currentLocation = cLocation;
        
        //Set the initial (current) orientation of the device in portrait mode
        self.currentOrientation = UIDeviceOrientationLandscapeLeft;
        
        //Set the view Range
        self.viewRange = self.overlayView.bounds.size.width / 12;
        
        //Set current Coordinate
        ARCoordinate *currentC = [[ARCoordinate alloc] initWithRadialDistance:1.0 andInclination:0 andAzimuth:0];
        self.currentCoordinate = currentC;        
        
        //Initialize the array that will store POIs visible and not visible (timeline ON)
        NSMutableArray *visibleCoordinate = [[NSMutableArray alloc] init];
        NSMutableArray *invisibleCoordinate = [[NSMutableArray alloc] init];
        
        //Retain the arrays
        self.coordinates =  visibleCoordinate;
        self.coordinatesNotVisualized = invisibleCoordinate;
        
    }
    return self;
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void)presentCameraAnimated:(BOOL) animated {
    [self.rootViewController presentModalViewController:[self cameraController] animated:animated]; 
    self.overlayView.frame = self.cameraController.view.bounds;    
}

- (void)addCoordinate:(ARCoordinate *)coordinate animated:(BOOL)animated{
    ARMarker *marker = [[ARMarker alloc] initWithCoordinate:coordinate]; 
    marker.arController = self;
    coordinate.coordinateMarker = marker;
    [coordinates addObject:coordinate];
}

- (void)removeCoordinate:(ARCoordinate *)coordinate animated:(BOOL)animated{
    [coordinates removeObject:coordinate];
}

#pragma mark - UIAccelerometerDelegate Methods

// Updates the ARGeoCoordinate when the device is moved
- (void)accelerometer:(UIAccelerometer *)meter didAccelerate:(UIAcceleration *)acceleration {
    switch (currentOrientation) { 
            
        case UIDeviceOrientationLandscapeLeft:
            self.viewAngle = atan2(acceleration.x, acceleration.z);
            break;
            
        case UIDeviceOrientationLandscapeRight:    
            self.viewAngle = atan2(-acceleration.x, acceleration.z);
            break;
            
        case UIDeviceOrientationPortrait:
            self.viewAngle = atan2(acceleration.y, acceleration.z);
            break; 
            
        case UIDeviceOrientationPortraitUpsideDown:
            self.viewAngle = atan2(-acceleration.y, acceleration.z); 
            break;
            
        default:
            break;
    } 
    
    [self updateCurrentCoordinate];
}

#pragma mark - CLLocationManagerDelegate Methods

// Updates the ARGeoCoordinate when the heading of the device changes
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy > 0) {
        self.currentHeading = newHeading; 
        
        [self updateCurrentCoordinate];
        
        double magneticHeading = newHeading.magneticHeading;
        
        double headingInRadians = degreesToRadians(magneticHeading);
        
        NSNumber *headingNSNumber = [NSNumber numberWithDouble:headingInRadians];
        
        [self updateClosestPointsHeading:headingNSNumber];
    }
}

// Updates the device position when the location of the device changes
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    if (newLocation != oldLocation) {
        [self updateCurrentLocation:newLocation];
        [self updateMapAnnotations:newLocation];
    }
}

//Shows the alert display when there is a compass interference 
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
    return YES;
}

#pragma mark - Notification Methods

// This method is called when the heading of the device changes. 
- (void)updateClosestPointsHeading:(NSNumber *)heading{
    //Update Annotations heading
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSHeadingUpdatedNotification" object:heading];
}

- (void)updateMapAnnotations:(CLLocation *)coordinate{
    //Update Annotations distance label
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSLocationUpdateAnnotations" object:coordinate];
}

#pragma mark - AR Methods

- (void)deviceOrientationDidChange:(NSNotification *)notification{
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    self.currentOrientation = orientation;
    
    //NSLog(@"Orientation after notification: %d",self.currentOrientation);
}

- (double)deltaAzimuthForCoordinate:(ARCoordinate *)coordinate {
    double currentAzimuth = self.currentCoordinate.coordinateAzimuth;
    double pointAzimuth	= coordinate.coordinateAzimuth;
    
    double deltaAzimith = ABS( pointAzimuth - currentAzimuth);
    
    if (currentAzimuth < degreesToRadians(self.viewRange) &&
        pointAzimuth > degreesToRadians(360-self.viewRange)) {
        deltaAzimith	= (currentAzimuth + ((M_PI * 2.0) - pointAzimuth));
    }
    else if (pointAzimuth < degreesToRadians(self.viewRange) &&
             currentAzimuth > degreesToRadians(360-self.viewRange)) {
        deltaAzimith	= (pointAzimuth + ((M_PI * 2.0) - currentAzimuth));
    }
    return deltaAzimith;
}

-(BOOL)isNorthForCoordinate:(ARCoordinate *)coordinate {
    BOOL isBetweenNorth = NO; 
    double currentAzimuth = self.currentCoordinate.coordinateAzimuth; 
    double pointAzimuth = coordinate.coordinateAzimuth;
    
    if ( currentAzimuth < degreesToRadians(self.viewRange) && pointAzimuth > degreesToRadians(360-self.viewRange) ) {
        isBetweenNorth = YES;
    }
    else if ( pointAzimuth < degreesToRadians(self.viewRange) && currentAzimuth > degreesToRadians(360-self.viewRange)) {
        isBetweenNorth = YES;
    }
    return isBetweenNorth;
}

- (CGPoint)pointForCoordinate:(ARCoordinate *)coordinate {
    CGPoint point;
    CGRect viewBounds = self.overlayView.bounds;
    double currentAzimuth = self.currentCoordinate.coordinateAzimuth; 
    double pointAzimuth = coordinate.coordinateAzimuth;
    double pointInclination = coordinate.coordinateInclination;
    
    double deltaAzimuth = [self deltaAzimuthForCoordinate:coordinate];
    BOOL isBetweenNorth = [self isNorthForCoordinate:coordinate];
    
    if ((pointAzimuth > currentAzimuth && !isBetweenNorth) || (currentAzimuth > degreesToRadians(360-self.viewRange) &&
                                                               pointAzimuth < degreesToRadians(self.viewRange))) {
        point.x = (viewBounds.size.width / 2) + ((deltaAzimuth / degreesToRadians(1)) * 12);
    }
    else{
        point.x = (viewBounds.size.width / 2) - ((deltaAzimuth / degreesToRadians(1)) * 12);
    }
    point.y = (viewBounds.size.height / 2) + (radiansToDegrees(M_PI_2 + self.viewAngle) * 2.0) + ((pointInclination / degreesToRadians(1)) * 12);
    
    return point;
}

- (BOOL)viewportContainsCoordinate:(ARCoordinate *)coordinate {
    double deltaAzimuth = [self deltaAzimuthForCoordinate:coordinate];
    BOOL result = NO; 
    
    // Filter on distance
    if ((deltaAzimuth <= degreesToRadians(self.viewRange)) && (coordinate.coordinateDistance <= 50)) {
        result = YES;
    }
    return result;
    
}

- (void)updateLocations {
    
    // if no visible markers, make sure all already drawn are removed
    if ( !coordinates || [coordinates count] == 0 ) {
        if ( !coordinatesNotVisualized || [coordinatesNotVisualized count] == 0 ) {
            return;
        } else {
            for (ARCoordinate *item in coordinatesNotVisualized) {
                UIView *viewToDraw = item.coordinateMarker; 
                
                if ([viewToDraw superview]) {
                    [viewToDraw removeFromSuperview];
                }
            }
            return;
        }
    }
    

    // draw visible markers, remove the others
    for (ARCoordinate *item in coordinates) {
        UIView *viewToDraw = item.coordinateMarker; 
        
        if ([self viewportContainsCoordinate:item]) {
            CGPoint point = [self pointForCoordinate:item];
            float width	= viewToDraw.bounds.size.width;
            float height = viewToDraw.bounds.size.height;
            viewToDraw.frame = CGRectMake(point.x - width / 2.0, point.y - (height / 2.0), width, height);
            
            if ( !([viewToDraw superview]) ) {
                [self.overlayView addSubview:viewToDraw];
                [self.overlayView sendSubviewToBack:viewToDraw];
                
            }
        }
        else{
            [viewToDraw removeFromSuperview];
        }
    }
    
}

//Changes coordinate of the device in relation of its orientation
- (void)updateCurrentCoordinate {
    
    self.currentCoordinate.coordinateAzimuth = degreesToRadians(self.currentHeading.magneticHeading);
    [self updateLocations];
    
}

//Changes coordinate of the device in relation of its position
- (void)updateCurrentLocation:(CLLocation *)newLocation {
    self.currentLocation = newLocation;
    
    for (ARGeoCoordinate *geoLocation in coordinates ) {
        if ( [geoLocation isKindOfClass:[ARGeoCoordinate class]]) {
            [geoLocation calibrateUsingOrigin:self.currentLocation];
        }
    }
}

@end
