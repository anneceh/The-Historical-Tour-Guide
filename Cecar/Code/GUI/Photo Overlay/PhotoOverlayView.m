//
//  PhotoOverlayView.m
//  Cecar
//
//  Created by Cecilie Haugstvedt on 01.02.12.
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

#import "PhotoOverlayView.h"

@implementation PhotoOverlayView

@synthesize backButton;
@synthesize closeButton;
@synthesize backgroundSwitch;
@synthesize photoOverlayView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // Initialize overlay view
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 700, 500)];
        self.photoOverlayView = imgView;
        
        //Initialize close button
        UIImage *closeButtonImage = [UIImage imageNamed:@"close.png"];
        UIButton *cb = [UIButton buttonWithType:UIButtonTypeCustom];
        cb.frame = CGRectMake(-6, -6, closeButtonImage.size.width, closeButtonImage.size.height);
        [cb setImage:closeButtonImage forState:UIControlStateNormal];
        self.closeButton = cb;
        
        //Initialize back button
        UIButton *bb = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [bb setTitle:@"Tilbake" forState:UIControlStateNormal];
        bb.frame = CGRectMake(585, 465, 100, 27);
        self.backButton = bb;
        
        UISwitch *bSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(5, 465, 100, 25)];
        [bSwitch setOn:NO animated:YES];
        self.backgroundSwitch = bSwitch;
                
                                                                       
        [self addSubview:self.photoOverlayView];
        [self sendSubviewToBack:self.photoOverlayView];
        [self addSubview:self.backButton];
        [self addSubview:self.backgroundSwitch];
        [self addSubview:self.closeButton];
        
    }
    return self;
}


@end
