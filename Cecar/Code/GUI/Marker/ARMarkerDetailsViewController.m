//
//  ARMarkerDetailsViewController.m
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

#import "ARMarkerDetailsViewController.h"
#import "ARController.h"
#import "ARMarker.h"
#import "ARMarkerDetailsView.h"
#import "ARCoordinate.h"
#import "Info.h"
#import "Photo.h"
#import "Store.h"
#import "PhotoView.h"
#import "PhotoOverlayView.h"
#import "StoreView.h"

#define DETAIL_VIEW_X       162
#define DETAIL_VIEW_Y       134
#define DETAIL_VIEW_WIDTH   700
#define DETAIL_VIEW_HEIGHT  500

#define MARGIN_STORE_LEFT       0
#define MARGIN_STORE_TOP        50
#define STORE_WIDTH             700
#define STORE_HEIGHT            450

#define MARGIN_PHOTO_LEFT       0
#define MARGIN_PHOTO_TOP        50
#define PHOTO_WIDTH             700
#define PHOTO_HEIGHT            450

#define OVERLAY_VIEW 2

@implementation ARMarkerDetailsViewController

@synthesize detailsView;
@synthesize marker;
@synthesize arCoordinate;
@synthesize photoView;
@synthesize photoOverlayView;
@synthesize storeView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initControllerWithCoordinate:(ARCoordinate *)coordinate{
    self = [super init];
    if (self) {
        self.arCoordinate = coordinate;
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
    ARMarkerDetailsView *mdv = [[ARMarkerDetailsView alloc] initWithFrame:CGRectMake(DETAIL_VIEW_X, DETAIL_VIEW_Y, DETAIL_VIEW_WIDTH, DETAIL_VIEW_HEIGHT)];
    mdv.detailsViewController = self;
    self.detailsView = mdv;
    self.view = mdv;
    
    // Add action to the close button
    [self.detailsView.detailCloseButton addTarget:self action:@selector(closeDetailView) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title
    self.detailsView.detailTitleLabel.text = self.arCoordinate.coordinateInformation.title;
    [self.detailsView.detailTitleLabel sizeToFit];
    
    // If the POI is a photo
    if (self.arCoordinate.coordinateInformation.type == InfoTypePhoto){
        PhotoView *ptv = [[PhotoView alloc] initWithFrame:CGRectMake(MARGIN_PHOTO_LEFT, MARGIN_PHOTO_TOP, PHOTO_WIDTH, PHOTO_HEIGHT)];
        self.photoView = ptv;
        [self.view addSubview:ptv];
        
        // Load and set the image, add action
        NSString *myImagePath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingString:[(Photo *)self.arCoordinate.coordinateInformation imagePath]];
        NSData *imageData =  [[NSData alloc] initWithContentsOfFile:myImagePath];
        UIImage *inputImage = [[UIImage alloc] initWithData:imageData];
        [self.photoView.photoButton setImage:inputImage forState:UIControlStateNormal];
        [self.photoView.photoButton addTarget:self action:@selector(showPhotoOverlay) forControlEvents:UIControlEventTouchUpInside];
        
        // Set description
        self.photoView.descriptionTextView.text = self.arCoordinate.coordinateInformation.description;
        
        // Add action to the overlay button
        [self.photoView.overlayButton addTarget:self action:@selector(showPhotoOverlay) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // If the POI is a store
    if (self.arCoordinate.coordinateInformation.type == InfoTypeStore){
        StoreView *stv = [[StoreView alloc] initWithFrame:CGRectMake(MARGIN_STORE_LEFT, MARGIN_STORE_TOP, STORE_WIDTH, STORE_HEIGHT)];
        self.storeView = stv;
        [self.view addSubview:stv];
        
        // Set address
        self.storeView.addressLabel.text = [(Store *)self.arCoordinate.coordinateInformation address];
        
        // Set description
        self.storeView.descriptionTextView.text = self.arCoordinate.coordinateInformation.description;
    }
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

- (void)closeDetailView{
    if (self.detailsView.superview != nil) {
        [self.detailsView removeFromSuperview];
    }
}

- (void)showPhotoOverlay{
//    //NSLog(@"showPhotoOverlay in ARMarkerDetailsViewController called");
    [self.detailsView removeFromSuperview];

    
    PhotoOverlayView *pov = [[PhotoOverlayView alloc] initWithFrame:CGRectMake(DETAIL_VIEW_X, DETAIL_VIEW_Y, DETAIL_VIEW_WIDTH, DETAIL_VIEW_HEIGHT)]; // frame not used anywhere, but the button doesnt work if its replaced with CGRectZero
    self.photoOverlayView = pov;    
        
    //Load image from file
    NSString *myImagePath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingString:[(Photo *)self.arCoordinate.coordinateInformation imagePath]];
    NSData *imageData =  [[NSData alloc] initWithContentsOfFile:myImagePath];
    UIImage *inputImage = [[UIImage alloc] initWithData:imageData];
    
    [self.photoOverlayView.photoOverlayView setClipsToBounds:YES];
    self.photoOverlayView.photoOverlayView.contentMode = UIViewContentModeScaleAspectFill; // scale image to fit in frame without changing the aspect ratio
    self.photoOverlayView.photoOverlayView.image = inputImage;
    
    // Add action to the back button
    [self.photoOverlayView.backButton addTarget:self action:@selector(backFromPhotoOverlay) forControlEvents:UIControlEventTouchUpInside];
    
    // Add action to the close button
    [self.photoOverlayView.closeButton addTarget:self action:@selector(closePhotoOverlay) forControlEvents:UIControlEventTouchUpInside];

    [self.photoOverlayView.backgroundSwitch addTarget:self action:@selector(switchOverlayBackground) forControlEvents:UIControlEventTouchUpInside];
    
    self.photoOverlayView.tag = OVERLAY_VIEW;
    [self.marker.arController.overlayView addSubview:self.photoOverlayView];
}

- (void)backFromPhotoOverlay{
    //NSLog(@"backFromPhotoOverlay in ARMarkerDetailsViewController called");
    
    [self.photoOverlayView removeFromSuperview];
    [self.marker showARMarkerDetailsView];
}

- (void)closePhotoOverlay{
//    //NSLog(@"closePhotoOverlay in ARMarkerDetailsViewController called");¢
    [self.photoOverlayView removeFromSuperview];
}

- (void)switchOverlayBackground{
    if (self.photoOverlayView.backgroundSwitch.on) {
        
        //Load image from file
        NSString *myImagePath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingString:[(Photo *)self.arCoordinate.coordinateInformation imagePath]];
        NSData *imageData =  [[NSData alloc] initWithContentsOfFile:myImagePath];
        UIImage *inputImage = [[UIImage alloc] initWithData:imageData];
        
        //Make image tranparent
        UIGraphicsBeginImageContext(CGSizeMake(inputImage.size.width, inputImage.size.height));		
        CGContextRef context = UIGraphicsGetCurrentContext();		
        UIGraphicsPushContext(context);								
        [inputImage drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeNormal alpha:0.6];
        UIGraphicsPopContext();								
        UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.photoOverlayView.photoOverlayView setClipsToBounds:YES];
        self.photoOverlayView.photoOverlayView.contentMode = UIViewContentModeScaleAspectFill; // scale image to fit in frame without changing the aspect ratio
        self.photoOverlayView.photoOverlayView.image = outputImage;
    }
	else {
        //Load image from file
        NSString *myImagePath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingString:[(Photo *)self.arCoordinate.coordinateInformation imagePath]];
        NSData *imageData =  [[NSData alloc] initWithContentsOfFile:myImagePath];
        UIImage *inputImage = [[UIImage alloc] initWithData:imageData];
        
        [self.photoOverlayView.photoOverlayView setClipsToBounds:YES];
        self.photoOverlayView.photoOverlayView.contentMode = UIViewContentModeScaleAspectFill; // scale image to fit in frame without changing the aspect ratio
        self.photoOverlayView.photoOverlayView.image = inputImage;
    }
}

@end
