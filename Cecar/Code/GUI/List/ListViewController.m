//
//  ListViewController.m
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

#import "ListViewController.h"
#import "ListButtonView.h"
#import "ListTableViewController.h"
#import "ARController.h"

@implementation ListViewController

@synthesize arController;
@synthesize listButtonView;
@synthesize popoverController;
@synthesize tableViewController;

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
    ListButtonView  *plbv = [[ListButtonView alloc] initWithFrame:CGRectZero];
    self.listButtonView = plbv;
    self.view = plbv;
    
    //Add the action to the list button
    [self.listButtonView.listButton addTarget:self action:@selector(listButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)listButtonPressed:(id)sender{
    
    if (self.popoverController == nil) {
        
        ListTableViewController *ptvc = [[ListTableViewController alloc] init];
        ptvc.contentSizeForViewInPopover = CGSizeMake(400, 750);
        ptvc.arController = self.arController;
        ptvc.listViewController = self;
        self.tableViewController = ptvc;
        
        self.popoverController = 
        [[UIPopoverController alloc] initWithContentViewController:ptvc]; 
        
    } else {
        [self.tableViewController.tableView reloadData];
    }
    
    [self.popoverController presentPopoverFromRect:self.listButtonView.frame
                                            inView:self.arController.overlayView
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:YES];
    
}

@end
