//
//  MasterViewController.h
//  Hotel New Hampshire
//
//  Created by Ben Tesch on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class Movie;

@interface MasterViewController : UITableViewController {
    AppDelegate *appDelegate;
    UIView *randomView;
    UITextView *randomText;
    UIView *helpView;
    UIView *helpOpacity;
    UITextView *welcomeTo;
    UITextView *welcomeTitle;
    UITextView *welcomeTitle2;
    UITextView *welcomeFooter;
    UITextView *helpText;
    UIView *helpFooterImage;
    UILabel *helpFooter;
}

@property (nonatomic, retain) UIView *randomView;
@property (nonatomic, retain) UITextView *randomText;
@property (nonatomic, retain) UIView *helpView;
@property (nonatomic, retain) UIView *helpOpacity;
@property (nonatomic, retain) UITextView *welcomeTo;
@property (nonatomic, retain) UITextView *welcomeTitle;
@property (nonatomic, retain) UITextView *welcomeTitle2;
@property (nonatomic, retain) UITextView *welcomeFooter;
@property (nonatomic, retain) UITextView *helpText;
@property (nonatomic, retain) UIView *helpFooterImage;
@property (nonatomic, retain) UILabel *helpFooter;

- (void) scrollToNextKeyword;
- (void) reloadTableView:(NSInteger)pk;


@end
