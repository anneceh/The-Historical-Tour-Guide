//
//  TimelineView.m
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

#import "TimelineView.h"

#define MARGIN_LEFT 0
#define MARGIN_TOP 718
#define TIMELINE_WIDTH 1024
#define TIMELINE_HEIGHT 60
#define LABEL_WIDTH 102
#define LABEL_HEIGHT 35

@implementation TimelineView

@synthesize l1, l2, l3, l4, l5, l6, l7, l8, l9, l10;

- (id)initWithFrame:(CGRect)frame
{
    //Set position and size of the timeline
    CGRect tFrame = CGRectMake(MARGIN_LEFT, MARGIN_TOP, TIMELINE_WIDTH, TIMELINE_HEIGHT);
    
    self = [super initWithFrame:tFrame];
    if (self) {
        
        // Set background image
        UIImage *timelineImage;
        UIImageView *timelineImageView = [[UIImageView alloc] initWithFrame:tFrame];
        timelineImage = [UIImage imageNamed:@"timeline.png"];  
        [timelineImageView setFrame:CGRectMake(MARGIN_LEFT, 0, timelineImage.size.width, timelineImage.size.height)];
        timelineImageView.image = timelineImage;
        
        // Create labels
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, (int)(timelineImageView.bounds.size.height/2) - 20.0 , LABEL_WIDTH, LABEL_HEIGHT)];
        lb1.font = [UIFont boldSystemFontOfSize:LABEL_HEIGHT];  //bold font
        lb1.backgroundColor = [UIColor clearColor];             //transparent background
        lb1.textAlignment = UITextAlignmentLeft;
        lb1.textColor = [UIColor whiteColor];
        lb1.text = @"1870";
        [lb1 sizeToFit];
        lb1.userInteractionEnabled = YES; 
        lb1.tag = 1;    //tag used to recognize which label is tapped
        self.l1 = lb1;
        
        UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_WIDTH, (int)(timelineImageView.bounds.size.height/2) - 20.0 , LABEL_WIDTH, LABEL_HEIGHT)];
        lb2.font = [UIFont boldSystemFontOfSize:LABEL_HEIGHT];  //bold font
        lb2.backgroundColor = [UIColor clearColor];             //transparent background
        lb2.textAlignment = UITextAlignmentLeft;
        lb2.textColor = [UIColor whiteColor];
        lb2.text = @"1880";
        [lb2 sizeToFit];
        lb2.userInteractionEnabled = YES; 
        lb2.tag = 2;    //tag used to recognize which label is tapped
        self.l2 = lb2;
        
        UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake((LABEL_WIDTH * 2), (int)(timelineImageView.bounds.size.height/2) - 20.0 , LABEL_WIDTH, LABEL_HEIGHT)];
        lb3.font = [UIFont boldSystemFontOfSize:LABEL_HEIGHT];  //bold font
        lb3.backgroundColor = [UIColor clearColor];             //transparent background
        lb3.textAlignment = UITextAlignmentLeft;
        lb3.textColor = [UIColor whiteColor];
        lb3.text = @"1890";
        [lb3 sizeToFit];
        lb3.userInteractionEnabled = YES; 
        lb3.tag = 3;    //tag used to recognize which label is tapped
        self.l3 = lb3;
        
        UILabel *lb4 = [[UILabel alloc] initWithFrame:CGRectMake((LABEL_WIDTH * 3), (int)(timelineImageView.bounds.size.height/2) - 20.0 , LABEL_WIDTH, LABEL_HEIGHT)];
        lb4.font = [UIFont boldSystemFontOfSize:LABEL_HEIGHT];  //bold font
        lb4.backgroundColor = [UIColor clearColor];             //transparent background
        lb4.textAlignment = UITextAlignmentLeft;
        lb4.textColor = [UIColor whiteColor];
        lb4.text = @"1900";
        [lb4 sizeToFit];
        lb4.userInteractionEnabled = YES; 
        lb4.tag = 4;    //tag used to recognize which label is tapped
        self.l4 = lb4;
        
        UILabel *lb5 = [[UILabel alloc] initWithFrame:CGRectMake((LABEL_WIDTH * 4), (int)(timelineImageView.bounds.size.height/2) - 20.0 , LABEL_WIDTH, LABEL_HEIGHT)];
        lb5.font = [UIFont boldSystemFontOfSize:LABEL_HEIGHT];  //bold font
        lb5.backgroundColor = [UIColor clearColor];             //transparent background
        lb5.textAlignment = UITextAlignmentLeft;
        lb5.textColor = [UIColor whiteColor];
        lb5.text = @"1910";
        [lb5 sizeToFit];
        lb5.userInteractionEnabled = YES; 
        lb5.tag = 5;    //tag used to recognize which label is tapped
        self.l5 = lb5;
        
        UILabel *lb6 = [[UILabel alloc] initWithFrame:CGRectMake((LABEL_WIDTH * 5), (int)(timelineImageView.bounds.size.height/2) - 20.0 , LABEL_WIDTH, LABEL_HEIGHT)];
        lb6.font = [UIFont boldSystemFontOfSize:LABEL_HEIGHT];  //bold font
        lb6.backgroundColor = [UIColor clearColor];             //transparent background
        lb6.textAlignment = UITextAlignmentLeft;
        lb6.textColor = [UIColor whiteColor];
        lb6.text = @"1920";
        [lb6 sizeToFit];
        lb6.userInteractionEnabled = YES; 
        lb6.tag = 6;    //tag used to recognize which label is tapped
        self.l6 = lb6;
        
        UILabel *lb7 = [[UILabel alloc] initWithFrame:CGRectMake((LABEL_WIDTH * 6), (int)(timelineImageView.bounds.size.height/2) - 20.0 , LABEL_WIDTH, LABEL_HEIGHT)];
        lb7.font = [UIFont boldSystemFontOfSize:LABEL_HEIGHT];  //bold font
        lb7.backgroundColor = [UIColor clearColor];             //transparent background
        lb7.textAlignment = UITextAlignmentLeft;
        lb7.textColor = [UIColor whiteColor];
        lb7.text = @"1930";
        [lb7 sizeToFit];
        lb7.userInteractionEnabled = YES; 
        lb7.tag = 7;    //tag used to recognize which label is tapped
        self.l7 = lb7;
        
        UILabel *lb8 = [[UILabel alloc] initWithFrame:CGRectMake((LABEL_WIDTH * 7), (int)(timelineImageView.bounds.size.height/2) - 20.0 , LABEL_WIDTH, LABEL_HEIGHT)];
        lb8.font = [UIFont boldSystemFontOfSize:LABEL_HEIGHT];  //bold font
        lb8.backgroundColor = [UIColor clearColor];             //transparent background
        lb8.textAlignment = UITextAlignmentLeft;
        lb8.textColor = [UIColor whiteColor];
        lb8.text = @"1940";
        [lb8 sizeToFit];
        lb8.userInteractionEnabled = YES; 
        lb8.tag = 8;    //tag used to recognize which label is tapped
        self.l8 = lb8;
        
        UILabel *lb9 = [[UILabel alloc] initWithFrame:CGRectMake((LABEL_WIDTH * 8), (int)(timelineImageView.bounds.size.height/2) - 20.0 , LABEL_WIDTH, LABEL_HEIGHT)];
        lb9.font = [UIFont boldSystemFontOfSize:LABEL_HEIGHT];  //bold font
        lb9.backgroundColor = [UIColor clearColor];             //transparent background
        lb9.textAlignment = UITextAlignmentLeft;
        lb9.textColor = [UIColor whiteColor];
        lb9.text = @"1950";
        [lb9 sizeToFit];
        lb9.userInteractionEnabled = YES; 
        lb9.tag = 9;    //tag used to recognize which label is tapped
        self.l9 = lb9;
        
        UILabel *lb10 = [[UILabel alloc] initWithFrame:CGRectMake((LABEL_WIDTH * 9), (int)(timelineImageView.bounds.size.height/2) - 20.0 , LABEL_WIDTH, LABEL_HEIGHT)];
        lb10.font = [UIFont boldSystemFontOfSize:LABEL_HEIGHT];  //bold font
        lb10.backgroundColor = [UIColor clearColor];             //transparent background
        lb10.textAlignment = UITextAlignmentLeft;
        lb10.textColor = [UIColor whiteColor];
        lb10.text = @"1960";
        [lb10 sizeToFit];
        lb10.userInteractionEnabled = YES; 
        lb10.tag = 10;    //tag used to recognize which label is tapped
        self.l10 = lb10;
        
        //Add the subviews to the main view
        [self addSubview:timelineImageView];
        [self addSubview:l1];
        [self addSubview:l2];
        [self addSubview:l3];
        [self addSubview:l4];
        [self addSubview:l5];
        [self addSubview:l6];
        [self addSubview:l7];
        [self addSubview:l8];
        [self addSubview:l9];
        [self addSubview:l10];
    

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
