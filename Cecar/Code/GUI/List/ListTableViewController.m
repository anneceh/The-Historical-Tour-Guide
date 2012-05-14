//
//  ListTableViewController.m
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

#import "ListTableViewController.h"
#import "ARController.h"
#import "ARCoordinate.h"
#import "ARMarker.h"
#import "Info.h"
#import "ListViewCell.h"
#import "ListViewController.h"

@implementation ListTableViewController

@synthesize arController;
@synthesize listViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arController.coordinates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    ARCoordinate *coordinate = [arController.coordinates objectAtIndex:indexPath.row];
    
    if ([coordinate isKindOfClass:[ARCoordinate class]]) {
        cell.primaryLabel.text = coordinate.coordinateInformation.title;
        cell.secondaryLabel.text = [NSString stringWithFormat:@"Avstand: %.0f m",coordinate.coordinateDistance];
        if (coordinate.coordinateInformation.type == InfoTypePhoto) {
            cell.myImageView.image = [UIImage imageNamed:@"photo.png"];
        } else {
            cell.myImageView.image = [UIImage imageNamed:@"store.png"];
        }
        
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.listViewController.popoverController dismissPopoverAnimated:NO];
     ARCoordinate *coordinate = [arController.coordinates objectAtIndex:indexPath.row];
    [coordinate.coordinateMarker showARMarkerDetailsView];     
}

@end
