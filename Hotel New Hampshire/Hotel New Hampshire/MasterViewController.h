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
}

- (void) countUp:(UISwipeGestureRecognizer *)recognizer;
- (void) scrollToNextKeyword;
- (void) reloadTableView:(NSInteger)pk;


@end
