//
//  TimelineView.h
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

@class TimelineViewController;

@interface TimelineView : UIView {
    UILabel *l1;
    UILabel *l2;
    UILabel *l3;
    UILabel *l4;
    UILabel *l5;
    UILabel *l6;
    UILabel *l7;
    UILabel *l8;
    UILabel *l9;
    UILabel *l10;
}
      
@property (nonatomic,retain) UILabel *l1;                                         
@property (nonatomic,retain) UILabel *l2;                                       
@property (nonatomic,retain) UILabel *l3;
@property (nonatomic,retain) UILabel *l4;                                         
@property (nonatomic,retain) UILabel *l5;                                       
@property (nonatomic,retain) UILabel *l6;
@property (nonatomic,retain) UILabel *l7;                                         
@property (nonatomic,retain) UILabel *l8;                                       
@property (nonatomic,retain) UILabel *l9;
@property (nonatomic,retain) UILabel *l10;  

@end
