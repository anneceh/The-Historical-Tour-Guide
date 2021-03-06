//
//  PhotoView.h
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

#import <UIKit/UIKit.h>

@interface PhotoView : UIView {
    UITextView *descriptionTextView;
    UIButton *overlayButton;
    UIButton *photoButton;
}

@property (nonatomic,retain) UITextView *descriptionTextView;
@property (nonatomic,retain) UIButton *overlayButton;
@property (nonatomic,retain) UIButton *photoButton;

@end
