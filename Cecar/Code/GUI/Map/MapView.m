//
//  MapView.m
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

#import "MapView.h"

@implementation MapView

@synthesize mapView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //State that the subviews are confined within its bounds
        self.clipsToBounds = YES;
        //Initialize the View that contains the map with position and size
        MKMapView *mv = [[MKMapView alloc] initWithFrame:CGRectMake(-50, -50, 950, 800)]; 
        //Set the alpha channel in order to overlay the map view to the camera view
        //mv.alpha = .45f;
        mv.alpha = 1.0f;
        //Set the map as standard map (Not satellite nor Hybrid)
        mv.mapType = MKMapTypeStandard;
        //Retains the map
        self.mapView = mv;
        //Add the map to the super view
        [self addSubview:mv];
    }
    return self;
}

@end
