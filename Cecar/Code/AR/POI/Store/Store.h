//
//  Store.h
//  Cecar
//
//  Created by Cecilie Haugstvedt on 16.01.12.
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
#import "Info.h"

@interface Store : Info {
    NSString *address;
}

@property (nonatomic,retain) NSString *address;        // address of the store

// Designated initializer, used to build "Store" objects.
- (id)initStoreWithTitle:(NSString *)aTitle type:(InfoType)aType description:(NSString *)aDescription location:(CLLocation *)aLocation address:(NSString *)anAddress;

@end
