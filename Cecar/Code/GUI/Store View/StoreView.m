//
//  StoreView.m
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

#import "StoreView.h"

#define MARGIN_LEFT 5
#define MARGIN_TOP 5
#define LABEL_WIDTH 650
#define LABEL_HEIGHT 25
#define TEXT_WIDTH 650
#define TEXT_HEIGHT 300


@implementation StoreView

@synthesize addressLabel;
@synthesize descriptionTextView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // Initialize address label
        UILabel *adr = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, LABEL_WIDTH, LABEL_HEIGHT)];
        adr.backgroundColor = [UIColor clearColor];
        adr.font = [UIFont boldSystemFontOfSize:22.0];
        adr.textColor = [UIColor whiteColor];
        adr.textAlignment = UITextAlignmentLeft; 
        self.addressLabel = adr;
                
        // Initialize description text view
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP + LABEL_HEIGHT +5, TEXT_WIDTH, TEXT_HEIGHT)];
        textView.backgroundColor = [UIColor clearColor];
        textView.font = [UIFont boldSystemFontOfSize:20.0];
        textView.textColor = [UIColor whiteColor];
        textView.textAlignment = UITextAlignmentLeft;
        textView.editable = NO;
        self.descriptionTextView = textView;
        
        // Add subviews
        [self addSubview:addressLabel];
        [self addSubview:textView];
        
    }
    return self;
}

@end
