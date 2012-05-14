//
//  ListButtonView.m
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

#import "ListButtonView.h"

#define BOX_WIDTH   100
#define BOX_HEIGHT  60
#define MARGIN_LEFT 924
#define MARGIN_TOP  260

@implementation ListButtonView

@synthesize listButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Set the background color
        self.backgroundColor = [UIColor colorWithWhite:.1 alpha:.9];
        //Set position and size of the box
        self.frame = CGRectMake(MARGIN_LEFT, MARGIN_TOP, BOX_WIDTH, BOX_HEIGHT);
        
        //Initilizing the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //Define the image for the button
        UIImage *buttonImage = [UIImage imageNamed:@"list.png"];
        
        [button setImage:buttonImage forState:UIControlStateNormal];
        [button setContentMode:UIViewContentModeCenter];
        button.frame = CGRectMake(0,0, BOX_WIDTH, BOX_HEIGHT);
        
        //Retains the navigation-assisted button
        self.listButton = button;
        
        //Add the button to the view
        [self addSubview:button];

    }
    return self;
}

@end
