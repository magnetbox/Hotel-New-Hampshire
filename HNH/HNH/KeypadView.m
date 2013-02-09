//
//  KeypadView.m
//  HNH
//
//  Created by j-btesch on 12/30/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "KeypadView.h"
#import <QuartzCore/QuartzCore.h>

@implementation KeypadView

@synthesize display;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self drawKeypad];
    }
    return self;
}

-(id)setupDotsStyle:(UIView*)dots{
    dots.userInteractionEnabled = NO;
    dots.exclusiveTouch = NO;
    return dots;
}

-(id)setupDotStyle:(UIView*)dot{
    dot.layer.cornerRadius = 5;
    dot.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:92.0f/255.0f blue:105.0f/255.0f alpha:1.0f];
    dot.layer.shadowColor = [UIColor whiteColor].CGColor;
    dot.layer.shadowOpacity = 0.8;
    dot.layer.shadowRadius = 2.5;
    dot.layer.shadowOffset = CGSizeMake(0,2.5f);
    dot.layer.masksToBounds = NO;
    dot.clipsToBounds = NO;
    dot.userInteractionEnabled = NO;
    dot.exclusiveTouch = NO;
    return dot;
}

-(id)setupButtonStyle:(UIButton*)button{
    button.clipsToBounds = YES;
    button.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [button setTitleColor:[UIColor colorWithRed:82.0f/255.0f green:92.0f/255.0f blue:105.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:1.0f alpha:0.8f] forState:UIControlStateNormal];
    [button.titleLabel setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    button.layer.cornerRadius = 3;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOpacity = 0.7;
    button.layer.shadowRadius = 2;
    button.layer.shadowOffset = CGSizeMake(0,2.0f);
    button.layer.masksToBounds = NO;
    return button;
}

- (void)drawKeypad
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,10,50,50)];
    pointsLabel.backgroundColor = [UIColor clearColor];
    pointsLabel.text = @"Points to add:";
    pointsLabel.textColor = [UIColor whiteColor];
    pointsLabel.font = [UIFont boldSystemFontOfSize:12.0];
    pointsLabel.numberOfLines = 0;
    [self addSubview:pointsLabel];
    
    display = [[UILabel alloc] initWithFrame:CGRectMake(75,10,500,50)];
    display.backgroundColor = [UIColor clearColor];
    display.text = @"0";
    display.textColor = [UIColor whiteColor];
    display.font = [UIFont boldSystemFontOfSize:48.0];
    [self addSubview:display];
    
}

@end
