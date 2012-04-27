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
    UIScrollView *helpView;
    UITextView *helpText;
}

@property (nonatomic, retain) UIView *randomView;
@property (nonatomic, retain) UITextView *randomText;
@property (nonatomic, retain) UIScrollView *helpView;
@property (nonatomic, retain) UITextView *helpText;

- (void) scrollToNextKeyword;
- (void) reloadTableView:(NSInteger)pk;


@end
