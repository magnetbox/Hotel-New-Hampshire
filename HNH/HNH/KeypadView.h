//
//  KeypadView.h
//  HNH
//
//  Created by j-btesch on 12/30/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface KeypadView : UIView {
    IBOutlet UIButton *movieButton;
    IBOutlet UILabel *movieTitle;
}

@property (nonatomic, retain) UIButton *movieButton;
@property (nonatomic, retain) UILabel *movieTitle;

-(void)setMovieButtonTitle:(Movie *)mov;

@end
