//
//  MapButtonView.m
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

#import "MapButtonView.h"

#define BOX_WIDTH   100
#define BOX_HEIGHT  60
#define MARGIN_LEFT 924
#define MARGIN_TOP  160

@implementation MapButtonView

@synthesize mapButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Set the background color
        self.backgroundColor = [UIColor colorWithWhite:.1 alpha:.9];
        //Set position and size of the box
        self.frame = CGRectMake(MARGIN_LEFT, MARGIN_TOP, BOX_WIDTH, BOX_HEIGHT);
        
        //Initilize the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //Define the image for the button
        UIImage *buttonImage = [UIImage imageNamed:@"map.png"];
        
        [button setImage:buttonImage forState:UIControlStateNormal];
        [button setContentMode:UIViewContentModeCenter];
        button.frame = CGRectMake(0,0, BOX_WIDTH, BOX_HEIGHT);
        
        //Retains the button
        self.mapButton = button;
        
        //Add the button to the view
        [self addSubview:button];
        
    }
    return self;
}

@end
