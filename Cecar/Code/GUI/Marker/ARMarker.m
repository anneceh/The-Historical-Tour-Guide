//
//  ARMarker.m
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


#import "ARMarker.h"
#import "ARCoordinate.h"
#import "ARController.h"
#import "ARMarkerDetailsViewController.h"
#import "ARMarkerDetailsView.h"
#import "Info.h"

#define BOX_WIDTH 150
#define BOX_HEIGHT 100
#define DETAILS_VIEW 1

@implementation ARMarker

@synthesize markerDetailsViewController;
@synthesize arController;
@synthesize coordinate;
@synthesize markerDetailView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoordinate:(ARCoordinate *)theCoordinate{
    
    CGRect theFrame = CGRectMake(0, 0, BOX_WIDTH, BOX_HEIGHT);
    
    self = [super initWithFrame:theFrame];
    
    if(self){
        
        self.coordinate = theCoordinate;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BOX_WIDTH,20.0)];
        titleLabel.backgroundColor = [UIColor colorWithWhite:.3 alpha:.2]; 
        titleLabel.textColor = [UIColor whiteColor]; 
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.text = coordinate.coordinateInformation.title;        
        [titleLabel sizeToFit];
        
        [titleLabel setFrame: CGRectMake(BOX_WIDTH / 2.0 - titleLabel.bounds.size.width / 2.0 - 4.0, 0, titleLabel.bounds.size.width + 8.0, titleLabel.bounds.size.height + 8.0)];
        
        NSString *imageName = [self imageForInfoType];
        UIImage *imageButton = [UIImage imageNamed:imageName];
        UIButton *detailViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [detailViewButton setBackgroundImage:imageButton forState:UIControlStateNormal];
        int posx = BOX_WIDTH / 2.0 - imageButton.size.width / 2.0;
        int posy = BOX_HEIGHT / 2.0 - imageButton.size.height / 2.0;
        detailViewButton.frame = CGRectMake(posx, posy, imageButton.size.width, imageButton.size.height);
        [detailViewButton addTarget:self action:@selector(showARMarkerDetailsView) forControlEvents:UIControlEventTouchDown];
       
        
        [self addSubview:titleLabel]; 
        [self addSubview:detailViewButton];
        [self setBackgroundColor:[UIColor clearColor]];         
        
    }
    
    return self;
}

- (void)showARMarkerDetailsView{
    
    //NSLog(@"ShowMarkerDetailsView");
    if (self.markerDetailsViewController.view.superview == nil) {
        
        // only one view open at a time
        for (UIView *aView in [self.arController.overlayView subviews]) {
            if (aView.tag == DETAILS_VIEW || aView.tag == 2) { // overlays tagged 2
                [aView removeFromSuperview];
            }
        }
        
        if (self.markerDetailsViewController.view == nil) {
            ARMarkerDetailsViewController *detailsViewController = [[ARMarkerDetailsViewController alloc] initControllerWithCoordinate:self.coordinate];
            self.markerDetailsViewController = detailsViewController;
            detailsViewController.marker = self; 
        }
        self.markerDetailsViewController.view.tag = DETAILS_VIEW;
        [self.arController.overlayView addSubview:self.markerDetailsViewController.view];
       
    }
    else{
        [self.markerDetailsViewController.view removeFromSuperview];
    }
}

- (NSString *)imageForInfoType{
    
    NSString *imageType;
    
    switch (self.coordinate.coordinateInformation.type) {
        case InfoTypePhoto:
            imageType = [NSString stringWithString:@"photo.png"];
            break;
        case InfoTypeStore:
            imageType = [NSString stringWithString:@"store.png"];
            break;
        default:
            imageType = [NSString stringWithString:@"unknown.png"];
            break;
    }
    
    return imageType;
}

@end
