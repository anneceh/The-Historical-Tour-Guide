//
//  ARMarker.h
//  MobileAR
//
//  Created by Alessandro Boron on 6/17/11.
//
//  Modified by Cecilie Haugstvedt
//  Cecar
//
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

@class ARController;
@class ARCoordinate;
@class ARMarkerDetailsViewController;
@class ARMarkerDetailsView;

@interface ARMarker : UIView {
    ARMarkerDetailsViewController *markerDetailsViewController;
    ARController *arController;
    ARCoordinate *coordinate;
    ARMarkerDetailsView *markerDetailView;
}

@property (nonatomic,retain) ARMarkerDetailsViewController *markerDetailsViewController; 
@property (nonatomic,retain) ARController *arController;
@property (nonatomic,retain) ARCoordinate *coordinate;
@property (nonatomic,retain) ARMarkerDetailsView *markerDetailView;

- (id)initWithCoordinate:(ARCoordinate *)coordinate;

- (void)showARMarkerDetailsView;

// method to select the marker icon to show depending on the type of information
- (NSString *)imageForInfoType;

@end

