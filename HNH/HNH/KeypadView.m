//
//  KeypadView.m
//  HNH
//
//  Created by j-btesch on 12/30/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "Movie.h"
#import "DetailViewController.h"
#import "KeypadView.h"
#import <QuartzCore/QuartzCore.h>

@implementation KeypadView

@synthesize movieButton, movieTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self drawKeypad];
    }
    return self;
}

- (void)drawKeypad
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather.png"]];

    movieButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [movieButton addTarget:self.superview action:@selector(scrollToNextKeyword) forControlEvents:UIControlEventTouchUpInside];
    
    movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, movieButton.frame.size.width-20.0, movieButton.frame.size.height-20.0) ];
    
    movieTitle.backgroundColor = [UIColor clearColor];
    movieTitle.textColor = [UIColor colorWithRed:230.0f/255.0f green:210.0f/255.0f blue:170.0f/255.0f alpha:1.0f];
    movieTitle.shadowColor = [UIColor colorWithRed:84.0f/255.0f green:31.0f/255.0f blue:7.0f/255.0f alpha:1.0f];
    movieTitle.shadowOffset = CGSizeMake(1,1);
    movieTitle.textAlignment = UITextAlignmentCenter;
    movieTitle.lineBreakMode = UILineBreakModeWordWrap;
    movieTitle.numberOfLines = 3;
    
    [movieButton addSubview:movieTitle];
    [self addSubview:movieButton];
    
}

-(void)setMovieButtonTitle:(Movie *)mov{
    
    UIFont *font = [UIFont fontWithName:@"Futura Md BT" size:24.0];
    NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", mov.mTitle, mov.mYear];
    movieString = [movieString uppercaseString];
    
    /* Calculate the needed font size. This for loop starts at the largest font size, and decreases by two point sizes (i=i-2) until it either hits a size that will fit or hits the minimum size we want to allow (i > 10) */
    int i;
    for(i = 24; i > 10; i=i-2)
    {
        // Set the new font size.
        font = [font fontWithSize:i];
        // NSLog(@"Trying size: %u", i);
        
        /* This step is important: We make a constraint box
         using only the fixed WIDTH of the UILabel. The height will
         be checked later. */
        NSLog(@"%f",self.frame.size.width);
        NSLog(@"%f",self.frame.size.height);
        CGSize constraintSize = CGSizeMake(self.frame.size.width-20.0f, MAXFLOAT);
        
        // This step checks how tall the label would be with the desired font.
        CGSize labelSize = [movieString sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        
        /* Here is where you use the height requirement!
         Set the value in the if statement to the height of your UILabel
         If the label fits into your required height, it will break the loop
         and use that font size. */
        if(labelSize.height <= self.frame.size.height-10.0f)
            break;
    }
    // You can see what size the function is using by outputting: NSLog(@"Best size is: %u", i);
    
    // Set the UILabel's font to the newly adjusted font.
    movieTitle.font = font;
    
    // Put the text into the UILabel outlet variable.
    movieTitle.text = movieString;
    
}

@end
