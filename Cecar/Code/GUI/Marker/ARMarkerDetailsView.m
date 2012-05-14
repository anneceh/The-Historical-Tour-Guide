//
//  ARMarkerDetailsView.m
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

#import "ARMarkerDetailsView.h"

#define TITLE_WIDTH 600
#define TITLE_HEIGHT 30
#define MARGIN_LEFT 40
#define MARGIN_TOP 0

@implementation ARMarkerDetailsView

@synthesize detailsViewController;
@synthesize detailTitleLabel;
@synthesize detailCloseButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Set the background 
        self.backgroundColor = [UIColor colorWithWhite:.1 alpha:.9];
        
        //Initialize close button
        UIImage *closeButtonImage = [UIImage imageNamed:@"close.png"];
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(-6, -6, closeButtonImage.size.width, closeButtonImage.size.height);
        [closeButton setImage:closeButtonImage forState:UIControlStateNormal];

        //Initialize title label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT + 10, MARGIN_TOP, TITLE_WIDTH, TITLE_HEIGHT)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:titleLabel.bounds.size.height];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = UITextAlignmentLeft; 
        
        // Add subviews to the main view
        self.detailCloseButton = closeButton;
        self.detailTitleLabel = titleLabel;
        
        [self addSubview:closeButton];
        [self addSubview:titleLabel];
    }
    return self;
}

@end
