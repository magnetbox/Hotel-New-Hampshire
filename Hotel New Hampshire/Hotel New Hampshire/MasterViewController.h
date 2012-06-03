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
    UILabel *welcomeTo;
    UILabel *welcomeTitle;
    UILabel *welcomeTitle2;
    UILabel *welcomeFooter;
    UILabel *helpText;
    UIView *helpFooterImage;
    UILabel *helpFooter;
    UIView *movieView;
    UIButton *movieButton;
    UILabel *movieTitle;
}

@property (nonatomic, retain) UIView *randomView;
@property (nonatomic, retain) UITextView *randomText;
@property (nonatomic, retain) UIView *helpView;
@property (nonatomic, retain) UIView *helpOpacity;
@property (nonatomic, retain) UILabel *welcomeTo;
@property (nonatomic, retain) UILabel *welcomeTitle;
@property (nonatomic, retain) UILabel *welcomeTitle2;
@property (nonatomic, retain) UILabel *welcomeFooter;
@property (nonatomic, retain) UILabel *helpText;
@property (nonatomic, retain) UIView *helpFooterImage;
@property (nonatomic, retain) UILabel *helpFooter;
@property (nonatomic, retain) UIView *movieView;
@property (nonatomic, retain) UIButton *movieButton;
@property (nonatomic, retain) UILabel *movieTitle;

- (void) scrollToNextKeyword;
- (void) reloadTableView:(NSInteger)pk;


@end
