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
    UITextView *welcomeTo;
    UITextView *welcomeTitle;
    UITextView *welcomeFooter;
    UITextView *helpText;
    UITextView *helpFooter;
}

@property (nonatomic, retain) UIView *randomView;
@property (nonatomic, retain) UITextView *randomText;
@property (nonatomic, retain) UIView *helpView;
@property (nonatomic, retain) UITextView *welcomeTo;
@property (nonatomic, retain) UITextView *welcomeTitle;
@property (nonatomic, retain) UITextView *welcomeFooter;
@property (nonatomic, retain) UITextView *helpText;
@property (nonatomic, retain) UITextView *helpFooter;

- (void) scrollToNextKeyword;
- (void) reloadTableView:(NSInteger)pk;


@end
