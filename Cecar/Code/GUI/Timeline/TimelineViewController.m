//
//  TimelineViewController.m
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

#import "TimelineViewController.h"
#import "ARController.h"
#import "ARCoordinate.h"
#import "ARGeoCoordinate.h"
#import "Info.h"
#import "Photo.h"
#import "TimelineView.h"

#define MARGIN_LEFT 0
#define MARGIN_TOP_IPAD 718
#define TIMELINE_WIDTH_IPAD 1024
#define TIMELINE_HEIGHT_IPAD 60

@implementation TimelineViewController

@synthesize timelineView;
@synthesize arController;
@synthesize tLabel;
@synthesize labelTapped;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

//Create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    TimelineView *tv = [[TimelineView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP_IPAD,TIMELINE_WIDTH_IPAD, TIMELINE_HEIGHT_IPAD)];
    self.timelineView = tv;
    self.view = tv;   
    
    //Initialize the tap gestures for the labels
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    UITapGestureRecognizer *tapGesture6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    UITapGestureRecognizer *tapGesture7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    UITapGestureRecognizer *tapGesture8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    UITapGestureRecognizer *tapGesture9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    UITapGestureRecognizer *tapGesture10 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    //Add the gestures to the labels
    [self.timelineView.l1 addGestureRecognizer:tapGesture1];
    [self.timelineView.l2 addGestureRecognizer:tapGesture2];
    [self.timelineView.l3 addGestureRecognizer:tapGesture3];
    [self.timelineView.l4 addGestureRecognizer:tapGesture4];
    [self.timelineView.l5 addGestureRecognizer:tapGesture5];
    [self.timelineView.l6 addGestureRecognizer:tapGesture6];
    [self.timelineView.l7 addGestureRecognizer:tapGesture7];
    [self.timelineView.l8 addGestureRecognizer:tapGesture8];
    [self.timelineView.l9 addGestureRecognizer:tapGesture9];
    [self.timelineView.l10 addGestureRecognizer:tapGesture10];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setTimelineView:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Implemented methods

//Method used to set the label on the top-left corner of the screen that inform the user about the time span of the information
- (void)setTime:(NSString *)time{
    
    //If the information with the timespan need to be shown on the screen
    if (time != nil) {
        
        NSInteger lowerYear = [time integerValue];
        NSInteger upperYear = lowerYear + 9;
        
        //Initialize the string from hours and minutes computed
        NSString *lowerbound = [[NSString alloc] initWithFormat:@"%04i",lowerYear];
        NSString *upperbound = [[NSString alloc] initWithFormat:@"%04i",upperYear];
        
        //Initialize the string to show
        NSString *timeshown = [[NSString alloc] initWithFormat:@"%@ - %@",lowerbound,upperbound];
        
        
        //Initialize the label used to show the time span with position and size
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 200, 20.0)];
        //Set the background color to transparent black
        timeLabel.backgroundColor = [UIColor colorWithWhite:.1 alpha:.9];
        //Set the font to bold
        timeLabel.font = [UIFont boldSystemFontOfSize:timeLabel.bounds.size.height];
        //Set the text color to whitre
        timeLabel.textColor = [UIColor whiteColor];
        //Set the alignment of the text to left
        timeLabel.textAlignment = UITextAlignmentLeft; 
        //Set the label content
        timeLabel.text = timeshown;
        //Text fits the label
        [timeLabel sizeToFit];
        
        //Set the timeline label
        if (self.tLabel.superview == nil) {
            if (self.tLabel == nil) {
                self.tLabel = timeLabel;
            }
            [self.arController.overlayView addSubview:self.tLabel];
        } else {
            self.tLabel.text = timeLabel.text;        
        }
    }
    
    //If the information have to disappear
    else{
        [self.tLabel removeFromSuperview];
        self.tLabel = nil;
    }
}

//Update information visible once the user tapped on a timeline label
- (void)updateInformation:(NSString *)year{
        
    //Initialize the arrays where information will be stored
    NSMutableArray *visible = [[NSMutableArray alloc] init];
    NSMutableArray *notVisible = [[NSMutableArray alloc] init];
    
    //Get the date from the date components
    NSInteger yearToShow = [year integerValue];
    
    if (year != nil) {
        
        //Walk through the coordinates array, find photos and filter these
        for (ARCoordinate *coordinate in self.arController.coordinates) {
            if ([coordinate isKindOfClass:[ARGeoCoordinate class]]) {
                if ([coordinate.coordinateInformation isKindOfClass:[Photo class]]) {
                    
                    NSInteger year = coordinate.coordinateInformation.year;
                    NSInteger interval = year - yearToShow;
                    
                    //If the interval is greater than 10 years the photo is not shown
                    if (interval>10 || interval<0) {
                        //Add the object to the array of information not visualized
                        [notVisible addObject:coordinate];
                        //Remove the icon from the screen
                        UIView *marker = (UIView *)coordinate.coordinateMarker;
                        [marker removeFromSuperview];                   
                    }
                    else{
                        [visible addObject:coordinate];
                    }
                } else { // stores not filtered
                    [visible addObject:coordinate];
                }          
            }
        }
        
        for (ARCoordinate *coordinate in self.arController.coordinatesNotVisualized) {
            if ([coordinate isKindOfClass:[ARGeoCoordinate class]]) {
                if ([coordinate.coordinateInformation isKindOfClass:[Photo class]]) {
                    
                    NSInteger year = coordinate.coordinateInformation.year;
                    NSInteger interval = year - yearToShow;
                    
                    //If the interval is greater than 10 years the photo is not shown
                    if (interval>10 || interval<0) {
                        //Add the object to the array of information not visualized
                        [notVisible addObject:coordinate];
                        //Remove the icon from the screen
                        UIView *marker = (UIView *)coordinate.coordinateMarker;
                        [marker removeFromSuperview];                   
                    }
                    else{
                        [visible addObject:coordinate];
                    }
                } else { // stores not filtered
                    [visible addObject:coordinate];
                }
            }
        }
    } else { // year == nil, timeline off
        for (ARCoordinate *coordinate in self.arController.coordinates) {
            if ([coordinate isKindOfClass:[ARGeoCoordinate class]]) {
                [visible addObject:coordinate];
            }
        }
        for (ARCoordinate *coordinate in self.arController.coordinatesNotVisualized) {
            if ([coordinate isKindOfClass:[ARGeoCoordinate class]]) {
                [visible addObject:coordinate];            }
        }
    }    
    self.arController.coordinatesNotVisualized = notVisible;
    self.arController.coordinates = visible;    
}

//Method used to handle the taps on the labels
- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded){
        
        //Get the label tapped
        UILabel *tapped = (UILabel *)sender.view;
        
        
        //If the label is not already tapped 
        if (!tap || ![tapped.text isEqualToString:self.labelTapped]) {
            tap = YES;
            
            if (sender.view.tag == 1) {
                //Get the text of the label
                self.labelTapped = self.timelineView.l1.text; 
                //Set the color of the tapped label to green, reset the rest of the labels to white
                self.timelineView.l1.textColor = [UIColor orangeColor];
                self.timelineView.l2.textColor = [UIColor whiteColor];
                self.timelineView.l3.textColor = [UIColor whiteColor];
                self.timelineView.l4.textColor = [UIColor whiteColor];
                self.timelineView.l5.textColor = [UIColor whiteColor];
                self.timelineView.l6.textColor = [UIColor whiteColor];
                self.timelineView.l7.textColor = [UIColor whiteColor];
                self.timelineView.l8.textColor = [UIColor whiteColor];
                self.timelineView.l9.textColor = [UIColor whiteColor];
                self.timelineView.l10.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 2) {
                self.labelTapped = self.timelineView.l2.text; 
                self.timelineView.l2.textColor = [UIColor orangeColor];
                self.timelineView.l1.textColor = [UIColor whiteColor];
                self.timelineView.l3.textColor = [UIColor whiteColor];
                self.timelineView.l4.textColor = [UIColor whiteColor];
                self.timelineView.l5.textColor = [UIColor whiteColor];
                self.timelineView.l6.textColor = [UIColor whiteColor];
                self.timelineView.l7.textColor = [UIColor whiteColor];
                self.timelineView.l8.textColor = [UIColor whiteColor];
                self.timelineView.l9.textColor = [UIColor whiteColor];
                self.timelineView.l10.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 3) {
                self.labelTapped = self.timelineView.l3.text; 
                self.timelineView.l3.textColor = [UIColor orangeColor];
                self.timelineView.l2.textColor = [UIColor whiteColor];
                self.timelineView.l1.textColor = [UIColor whiteColor];
                self.timelineView.l4.textColor = [UIColor whiteColor];
                self.timelineView.l5.textColor = [UIColor whiteColor];
                self.timelineView.l6.textColor = [UIColor whiteColor];
                self.timelineView.l7.textColor = [UIColor whiteColor];
                self.timelineView.l8.textColor = [UIColor whiteColor];
                self.timelineView.l9.textColor = [UIColor whiteColor];
                self.timelineView.l10.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 4) {
                self.labelTapped = self.timelineView.l4.text; 
                self.timelineView.l4.textColor = [UIColor orangeColor];
                self.timelineView.l2.textColor = [UIColor whiteColor];
                self.timelineView.l3.textColor = [UIColor whiteColor];
                self.timelineView.l1.textColor = [UIColor whiteColor];
                self.timelineView.l5.textColor = [UIColor whiteColor];
                self.timelineView.l6.textColor = [UIColor whiteColor];
                self.timelineView.l7.textColor = [UIColor whiteColor];
                self.timelineView.l8.textColor = [UIColor whiteColor];
                self.timelineView.l9.textColor = [UIColor whiteColor];
                self.timelineView.l10.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 5) {
                self.labelTapped = self.timelineView.l5.text; 
                self.timelineView.l5.textColor = [UIColor orangeColor];
                self.timelineView.l2.textColor = [UIColor whiteColor];
                self.timelineView.l3.textColor = [UIColor whiteColor];
                self.timelineView.l4.textColor = [UIColor whiteColor];
                self.timelineView.l1.textColor = [UIColor whiteColor];
                self.timelineView.l6.textColor = [UIColor whiteColor];
                self.timelineView.l7.textColor = [UIColor whiteColor];
                self.timelineView.l8.textColor = [UIColor whiteColor];
                self.timelineView.l9.textColor = [UIColor whiteColor];
                self.timelineView.l10.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 6) {
                self.labelTapped = self.timelineView.l6.text; 
                self.timelineView.l6.textColor = [UIColor orangeColor];
                self.timelineView.l2.textColor = [UIColor whiteColor];
                self.timelineView.l3.textColor = [UIColor whiteColor];
                self.timelineView.l4.textColor = [UIColor whiteColor];
                self.timelineView.l5.textColor = [UIColor whiteColor];
                self.timelineView.l1.textColor = [UIColor whiteColor];
                self.timelineView.l7.textColor = [UIColor whiteColor];
                self.timelineView.l8.textColor = [UIColor whiteColor];
                self.timelineView.l9.textColor = [UIColor whiteColor];
                self.timelineView.l10.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 7) {
                self.labelTapped = self.timelineView.l7.text; 
                self.timelineView.l7.textColor = [UIColor orangeColor];
                self.timelineView.l2.textColor = [UIColor whiteColor];
                self.timelineView.l3.textColor = [UIColor whiteColor];
                self.timelineView.l4.textColor = [UIColor whiteColor];
                self.timelineView.l5.textColor = [UIColor whiteColor];
                self.timelineView.l6.textColor = [UIColor whiteColor];
                self.timelineView.l1.textColor = [UIColor whiteColor];
                self.timelineView.l8.textColor = [UIColor whiteColor];
                self.timelineView.l9.textColor = [UIColor whiteColor];
                self.timelineView.l10.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 8) {
                self.labelTapped = self.timelineView.l8.text; 
                self.timelineView.l8.textColor = [UIColor orangeColor];
                self.timelineView.l2.textColor = [UIColor whiteColor];
                self.timelineView.l3.textColor = [UIColor whiteColor];
                self.timelineView.l4.textColor = [UIColor whiteColor];
                self.timelineView.l5.textColor = [UIColor whiteColor];
                self.timelineView.l6.textColor = [UIColor whiteColor];
                self.timelineView.l7.textColor = [UIColor whiteColor];
                self.timelineView.l1.textColor = [UIColor whiteColor];
                self.timelineView.l9.textColor = [UIColor whiteColor];
                self.timelineView.l10.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 9) {
                self.labelTapped = self.timelineView.l9.text; 
                self.timelineView.l9.textColor = [UIColor orangeColor];
                self.timelineView.l2.textColor = [UIColor whiteColor];
                self.timelineView.l3.textColor = [UIColor whiteColor];
                self.timelineView.l4.textColor = [UIColor whiteColor];
                self.timelineView.l5.textColor = [UIColor whiteColor];
                self.timelineView.l6.textColor = [UIColor whiteColor];
                self.timelineView.l7.textColor = [UIColor whiteColor];
                self.timelineView.l8.textColor = [UIColor whiteColor];
                self.timelineView.l1.textColor = [UIColor whiteColor];
                self.timelineView.l10.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 10) {
                self.labelTapped = self.timelineView.l10.text; 
                self.timelineView.l10.textColor = [UIColor orangeColor];
                self.timelineView.l2.textColor = [UIColor whiteColor];
                self.timelineView.l3.textColor = [UIColor whiteColor];
                self.timelineView.l4.textColor = [UIColor whiteColor];
                self.timelineView.l5.textColor = [UIColor whiteColor];
                self.timelineView.l6.textColor = [UIColor whiteColor];
                self.timelineView.l7.textColor = [UIColor whiteColor];
                self.timelineView.l8.textColor = [UIColor whiteColor];
                self.timelineView.l9.textColor = [UIColor whiteColor];
                self.timelineView.l1.textColor = [UIColor whiteColor];
            }
            
            //Update POIs on the screen
            [self updateInformation:self.labelTapped];
            
            //Set the timestamp label that specify the timespan
            [self setTime:self.labelTapped];
        }
        
        //If the label was already tapped
        else {
            tap = NO;
            
            if (sender.view.tag == 1) {
                //Set the color of the label to white
                self.timelineView.l1.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 2) {
                self.timelineView.l2.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 3) {
                self.timelineView.l3.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 4) {
                self.timelineView.l4.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 5) {
                self.timelineView.l5.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 6) {
                self.timelineView.l6.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 7) { 
                self.timelineView.l7.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 8) { 
                self.timelineView.l8.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 9) { 
                self.timelineView.l9.textColor = [UIColor whiteColor];
            } else if (sender.view.tag == 10) { 
                self.timelineView.l10.textColor = [UIColor whiteColor];
            }
            
            //Update the information with timestamp = nil so all the information are displayed again to the screen
            [self updateInformation:nil]; 
            //Update the label that shows the times span to nil thereby it will be removed from the screen
            [self setTime:nil];
        }
    }
}


@end
