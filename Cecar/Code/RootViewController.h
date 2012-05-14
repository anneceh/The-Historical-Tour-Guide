//
//  RootViewController.h
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

@class ARController;
@class InfoViewController;
@class ListViewController;
@class MapViewController;
@class TimelineViewController;

@interface RootViewController : UIViewController {
    ARController *arController;    
    InfoViewController *infoViewController;
    ListViewController *listViewController;
    TimelineViewController *timelineViewController;
    MapViewController *mapViewController;
}

@property (nonatomic, retain) ARController *arController;
@property (nonatomic, retain) InfoViewController *infoViewController;
@property (nonatomic, retain) ListViewController *listViewController;
@property (nonatomic, retain) TimelineViewController *timelineViewController;
@property (nonatomic, retain) MapViewController *mapViewController;

// Add POIs manually instead of using  a data source
- (void)addData;

@end
