//
//  DetailViewController.h
//  HNH
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "KeypadView.h"
#import "AppDelegate.h"

@protocol KeypadViewControllerDelegate <UITableViewDelegate>
- (void)endTurn:(id)sender;
@end

@class Movie;
@class Keywords;

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    AppDelegate *appDelegate;
    KeypadView *keypad;
    UITableView *keywordList;
}

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) Game *game;
@property (strong, nonatomic) Movie *currentMovie;
@property (strong, nonatomic) NSMutableArray *currentKeywords;
@property (nonatomic, retain) UIView *keypad;
@property (nonatomic, retain) UITableView *keywordList;

- (void) updatePlayerScore:(int)player;
- (void) scrollToNextKeyword;
- (void) reloadTableView:(NSInteger)pk;

@end
