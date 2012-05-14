//
//  Info.m
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

#import "Info.h"

@implementation Info

@synthesize title;
@synthesize type;
@synthesize description;
@synthesize location;
@synthesize year;

- (id)initInfoWithTitle:(NSString *)aTitle type:(InfoType)aType description:(NSString *)aDescription location:(CLLocation *)aLocation {
    self = [super init];
    
    if (self) {
        self.title = aTitle;
        self.type = aType;
        self.description = aDescription;
        self.location = aLocation;
    }
    
    return self;
    
}

- (NSString *)infoMediaTypeDescription{
    if (type == InfoTypeStore) {
        return @"Store";
    } else if (type == InfoTypePhoto) {
        return @"Photo";
    } else {
        return @"Unknown";
    }
}

@end
