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
    NSMutableArray *movieArray;
    NSMutableArray *keywordArray;
    NSString *lastKeywordSelected;
    NSInteger lastMovieID;
}

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) Game *game;

@property (nonatomic, retain) UIView *keypad;
@property (nonatomic, retain) UITableView *keywordList;

@property (nonatomic, retain) NSMutableArray *movieArray;
@property (nonatomic, retain) NSMutableArray *keywordArray;
@property (nonatomic, assign) NSInteger lastMovieID;
@property (nonatomic, retain) NSString *lastKeywordSelected;
@property (nonatomic, assign) NSInteger lastKeywordRowViewed;

- (void)updatePlayerScore:(int)player;

@end
