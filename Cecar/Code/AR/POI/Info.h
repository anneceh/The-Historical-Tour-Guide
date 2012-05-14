//
//  Info.h
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

typedef enum {
    InfoTypePhoto = 0,
    InfoTypeStore,
} InfoType;

// A class representing a piece of information associated with an ARCoordinate (POI)
// Subclassed by two specific types of information: Photo and Address.
@interface Info : NSObject {
    NSString *title;
    NSString *description;
    CLLocation *location;
    NSInteger year;
}
@property (nonatomic) NSInteger year;       // Only set if the information is of type Photo
@property (nonatomic, retain) NSString *title;          
@property (nonatomic, retain) NSString *description; 
@property (nonatomic, retain) CLLocation *location;     // Hack, same location here as in ARGeoCoordinate
@property (nonatomic) InfoType type;                    // Type of info - e.g. "Photo" or "Store"

// Initializer, used to build "Info" objects. Never used directly, but called by subclasses.
- (id)initInfoWithTitle:(NSString *)aTitle type:(InfoType)aType description:(NSString *)aDescription location:(CLLocation *)aLocation;

//Method used to get a string representation of the information type.
 - (NSString *)infoMediaTypeDescription;

@end
