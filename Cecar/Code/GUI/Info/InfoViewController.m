//
//  InfoViewController.m
//  Cecar
//
//  Created by Cecilie Haugstvedt on 12.01.12.
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

#import "InfoViewController.h"
#import "ARController.h"
#import "InfoButtonView.h"
#import "InfoView.h"

#define INFO_VIEW_X       162
#define INFO_VIEW_Y       134
#define INFO_VIEW_WIDTH   700
#define INFO_VIEW_HEIGHT  500

@implementation InfoViewController

@synthesize arController;
@synthesize infoButtonView;
@synthesize infoView;

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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    
    // Initialize the button
    InfoButtonView  *plbv = [[InfoButtonView alloc] initWithFrame:CGRectZero];
    self.infoButtonView = plbv;
    self.view = plbv;
    
    //Add the action to the list button
    [self.infoButtonView.infoButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    InfoView *iv = [[InfoView alloc] initWithFrame:CGRectMake(INFO_VIEW_X, INFO_VIEW_Y, INFO_VIEW_WIDTH, INFO_VIEW_HEIGHT)];
    self.infoView = iv;
    [self.infoView.infoCloseButton addTarget:self action:@selector(closeInfoView) forControlEvents:UIControlEventTouchUpInside];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)infoButtonPressed:(id)sender {
    [self.arController.overlayView addSubview:self.infoView];
}

- (void)closeInfoView{
    [self.infoView removeFromSuperview];
}
@end
