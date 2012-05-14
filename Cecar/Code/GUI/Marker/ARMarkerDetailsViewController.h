//
//  ARMarkerDetailsViewController.h
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

@class ARMarkerDetailsView;
@class ARMarker;
@class ARCoordinate;
@class PhotoView;
@class PhotoOverlayView;
@class StoreView;

@interface ARMarkerDetailsViewController : UIViewController {
    ARMarker *marker;
    ARMarkerDetailsView *detailsView;
    ARCoordinate *arCoordinate;
    PhotoView *photoView;
    PhotoOverlayView *photoOverlayView;
    StoreView *storeView;
}

@property (nonatomic, retain) ARMarker *marker;
@property (nonatomic,retain) ARMarkerDetailsView *detailsView;
@property (nonatomic,retain) ARCoordinate *arCoordinate;
@property (nonatomic,retain) PhotoView *photoView;
@property (nonatomic,retain) PhotoOverlayView *photoOverlayView;
@property (nonatomic,retain) StoreView *storeView;

- (id)initControllerWithCoordinate:(ARCoordinate *)coordinate;

- (void)closeDetailView;

- (void)showPhotoOverlay;

- (void)closePhotoOverlay;

- (void)backFromPhotoOverlay;

@end