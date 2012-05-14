//
//  PhotoView.m
//  Cecar
//
//
//  PhotoView.m
//  Cecar
//
//  Created by Cecilie Haugstvedt on 13.01.12.
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

#import "PhotoView.h"

#define MARGIN_LEFT 0
#define MARGIN_TOP 5
#define IMAGE_HEIGHT 200
#define IMAGE_WIDHT 300
#define LABEL_WIDTH 650
#define LABEL_HEIGHT 20
#define TEXT_WIDTH 650
#define TEXT_HEIGHT 170

@implementation PhotoView

@synthesize descriptionTextView;
@synthesize overlayButton;
@synthesize photoButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // Initialize image
        UIButton *pb = [UIButton buttonWithType:UIButtonTypeCustom];
        pb.frame = CGRectMake(200, 0, 280, 200);
        self.photoButton = pb;
        
        // Initialize description text view
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP + IMAGE_HEIGHT, TEXT_WIDTH, TEXT_HEIGHT)];
        textView.backgroundColor = [UIColor clearColor];
        textView.font = [UIFont boldSystemFontOfSize:20.0];
        textView.textColor = [UIColor whiteColor];
        textView.textAlignment = UITextAlignmentLeft;
        textView.editable = NO;
        self.descriptionTextView = textView;
        
        // Initialize overlay button
        UIButton *orb = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [orb setTitle:@"Vis bilde" forState:UIControlStateNormal];
        orb.frame = CGRectMake(585, MARGIN_TOP + IMAGE_HEIGHT + LABEL_HEIGHT + LABEL_HEIGHT + TEXT_HEIGHT, 100, 27);
        self.overlayButton = orb;
        
        // Add subviews
        [self addSubview:descriptionTextView];
        [self addSubview:overlayButton];
        [self addSubview:photoButton];
    }
    return self;
}

@end
