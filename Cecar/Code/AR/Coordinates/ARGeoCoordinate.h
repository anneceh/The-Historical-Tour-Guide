//
//  ARGeoCoordinate.h
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
#import "ARCoordinate.h"

@class Info;

// A subclass of ARCoordinate. Represents a POI with a physical location. 
@interface ARGeoCoordinate : ARCoordinate {
    CLLocation * coordinateGeoLocation;
}

@property (nonatomic, retain) CLLocation *coordinateGeoLocation;  

// Initializer used to make a POI given a location and associated information 
- (id)initWithCoordinate:(CLLocation *)location andInfo:(Info *)information; 

// Initializer used to make a POI given a location and the position of the user 
- (id)initWithCoordinate:(CLLocation *)location andOrigin:(CLLocation *)origin; 

// Computes the angle between two coordinates
- (float)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second;

// Sets the distance, inclination and azimuth of a POI in relation to the user position. 
// Is called every time the user changes his or hers position
- (void)calibrateUsingOrigin:(CLLocation *)origin;

@end
