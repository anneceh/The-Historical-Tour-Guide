//
//  MapViewAnnotation.h
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
#import <MapKit/MapKit.h>

typedef enum {
    AnnotationTypeUnknown = 0,
    AnnotationTypePhoto,
    AnnotationTypeStore
} AnnotationType;

@interface MapViewAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    double distanceKm;
    AnnotationType annotationType;
}

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;       // The coordinate of the annotation
@property (nonatomic,retain) NSString *title;                           // The main title used to specify the type of info
@property (nonatomic,retain) NSString *subtitle;                        // The subtitle used to specify the distance from the user
@property (nonatomic,assign) double distanceKm;                         // The distance from the user location
@property (nonatomic,assign) AnnotationType annotationType;             // Used to determine the pin to show on the map

// Designated initializer
- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t subtitle:(NSString *)st;

// Used to move user annotation on map
- (void)moveAnnotation:(CLLocationCoordinate2D)newLocation;

@end
