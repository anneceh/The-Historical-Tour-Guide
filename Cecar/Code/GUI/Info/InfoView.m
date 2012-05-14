//
//  InfoView.m
//  Cecar
//
//  Created by Cecilie Haugstvedt on 19.01.12.
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

#import "InfoView.h"

#define TITLE_WIDTH 600
#define TITLE_HEIGHT 30
#define MARGIN_LEFT 40
#define MARGIN_TOP 0
#define TEXT_WIDTH 650
#define TEXT_HEIGHT 500

@implementation InfoView

@synthesize infoCloseButton;
@synthesize infoTextView;
@synthesize infoTitleLabel;
@synthesize infoViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Set the background 
        self.backgroundColor = [UIColor colorWithWhite:.1 alpha:.9];
        
        //Initialize close button
        UIImage *closeButtonImage = [UIImage imageNamed:@"close.png"];
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(-6, -6, closeButtonImage.size.width, closeButtonImage.size.height);
        [closeButton setImage:closeButtonImage forState:UIControlStateNormal];
        
        //Initialize title label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, TITLE_WIDTH, TITLE_HEIGHT)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:titleLabel.bounds.size.height];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = UITextAlignmentLeft; 
        titleLabel.text = @"Historisk turguide for Nordre gate";
        
        // Initialize text view
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP + TITLE_HEIGHT, TEXT_WIDTH, TEXT_HEIGHT)];
        textView.backgroundColor = [UIColor clearColor];
        textView.font = [UIFont boldSystemFontOfSize:20.0];
        textView.textColor = [UIColor whiteColor];
        textView.textAlignment = UITextAlignmentLeft;
        textView.text = @"Turguiden viser historiske bilder og informasjon fra Nordre gate i Trondheim. \n \nNår du holder opp ipad-en foran et bygg der det er lagt innn informasjon ser du en markør som du kan trykke på for å se på bildet og få opp mer informasjon. \n \nPå høyre side av skjermen er det tre knapper: Infoknappen bringer deg til denne siden. Globusknappen åpner et kart med markører som angir hvor det er lagt inn informasjon og hvor langt det er dit. Listeknappen bringer deg til en liste over all punkter der det er lagt inn informasjon. Ved å trykke på et punkt i listen åpner du siden med mer informasjon om punktet. \n \nNederst på skjermen er en tidslinje. Ved å trykke på den kan du velge å se bilder fra et bestemt tiår. Trykker du to ganger på samme tall går du tilbake til visningen der alle bildene er synlig.";
        textView.editable = NO;
        
        self.infoCloseButton = closeButton;
        self.infoTitleLabel = titleLabel;
        self.infoTextView = textView;
        
        [self addSubview:closeButton];
        [self addSubview:titleLabel];
        [self addSubview:textView];
    }
    return self;
}


@end
