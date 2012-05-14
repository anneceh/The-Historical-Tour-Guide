//
//  ARGeoCoordinate.m
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

#import "ARGeoCoordinate.h"

@implementation ARGeoCoordinate

@synthesize coordinateGeoLocation;

- (id)initWithCoordinate:(CLLocation *)location andInfo:(Info *)information {
    self = [super init];
    
    if(self != nil){
        self.coordinateGeoLocation = location; 
        super.coordinateInformation = information;
    } 
    
    return self;
}

- (id)initWithCoordinate:(CLLocation *)location andOrigin:(CLLocation *)origin {    
    self = [super init];
    
    if(self){
        self.coordinateGeoLocation = location;
        [self calibrateUsingOrigin:origin];
    }
    return self;
}

- (void)calibrateUsingOrigin:(CLLocation *)origin {
    
    // Ignore altitude
    self.coordinateDistance = [origin distanceFromLocation:self.coordinateGeoLocation];
    self.coordinateInclination = 0;
    
    //Computes the azimuth of the POI in respect to the position of the user
    self.coordinateAzimuth = [self angleFromCoordinate:[origin coordinate] toCoordinate:[self.coordinateGeoLocation coordinate]];
}

- (float)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second {
    float longitudinalDifference = second.longitude - first.longitude; 
    float latitudinalDifference	= second.latitude - first.latitude;
    float possibleAzimuth = (M_PI * .5f) - atan(latitudinalDifference / longitudinalDifference);
    
    if (longitudinalDifference > 0) 
        return possibleAzimuth;
    else if (longitudinalDifference < 0)
        return possibleAzimuth + M_PI; 
    else if (latitudinalDifference < 0)
        return M_PI; 
    
    return 0.0f;
}

@end
