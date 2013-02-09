//
//  DetailViewController.m
//  HNH
//
//  Created by Ben Tesch on 12/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "DetailViewController.h"
#import "Game.h"
#import "KeypadView.h"
#import "KeywordCell.h"
#import "Movie.h"
#import "Keywords.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize game, keypad, keywordList;
@synthesize movieArray, keywordArray, lastMovieID, lastKeywordSelected, lastKeywordRowViewed;

#pragma mark - Managing the detail item

- (void)buttonPressed:(id)sender {
    NSLog(@"DIGIT PRESSED: %d", [sender tag]);
    NSInteger total = [keypad.display.text intValue];
    keypad.display.text = [NSString stringWithFormat:@"%d", total+[sender tag]];
}

- (void)clearDisplay {
    NSLog(@"CLEAR");
    keypad.display.text = @"0";
}

- (void)endTurn:(id)sender {
    NSLog(@"END TURN");
    
    // update score display
    [self updatePlayerScore:[self.game gamePlayersTurn]];

    // select next player
    [self.game setGamePlayersTurn:[self.game gamePlayersTurn] + 1];
    if ([self.game gamePlayersTurn]>([[self.game gamePlayers] count]-1)) {
        [self.game setGamePlayersTurn:0];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.game gamePlayersTurn] inSection:0];
    [keywordList selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];

    [self clearDisplay];
    [self saveGames];
}

- (void)saveGames {
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *myEncodedActive = [NSKeyedArchiver archivedDataWithRootObject:appDelegate.activeGames];
    [userDefault setObject:myEncodedActive forKey:[NSString stringWithFormat:@"activeGames"]];
    NSData *myEncodedInactive = [NSKeyedArchiver archivedDataWithRootObject:appDelegate.inactiveGames];
    [userDefault setObject:myEncodedInactive forKey:[NSString stringWithFormat:@"inactiveGames"]];
    [userDefault synchronize];
    NSLog(@"SAVED TO USERDEFAULTS");
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    /*
     if (self.detailItem) {
     self.detailDescriptionLabel.text = [self.detailItem description];
     }
     */
    self.title = self.game.gameTitle;
    game = self.game;

    NSLog(@"TITLE: %@",self.title);
    //NSLog(@"ACTIVE: %c",self.game.gameActive);
    
    int keypadHeight = 170;

    // add player list
    keywordList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-keypadHeight) style:UITableViewStylePlain];
    keywordList.backgroundColor = [UIColor clearColor];
    keywordList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [keywordList setAutoresizesSubviews:YES];
    [keywordList setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [keywordList setDelegate:self];
    [keywordList setDataSource:self];
    
    // add keypad
    keypad = [[KeypadView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-keypadHeight, self.view.frame.size.width, keypadHeight)];
    [keypad setAutoresizesSubviews:YES];
    [keypad setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth)];
    
    [self.view addSubview:keywordList];
    [self.view addSubview:keypad];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [[self.game gamePlayers] count];
    NSLog(@"PLAYERS: %d",rows);
    return rows;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Customize keyword cell
    cell.textLabel.font = [UIFont fontWithName:@"Futura Md BT" size:16.0];
    cell.textLabel.textColor = [UIColor colorWithRed:245.0f/255.0f green:225.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:self.keywordList.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    
    Keywords *kObj = [keywordArray objectAtIndex:indexPath.row];
    NSString* keywordString = [NSString stringWithFormat:@"%@", kObj.kTitle];
    keywordString = [keywordString stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    keywordString = [keywordString uppercaseString];
    cell.textLabel.text = keywordString;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    self.game.gamePlayersTurn = indexPath.row;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    NSMutableArray *tempMovieArray = [[NSMutableArray alloc] init];
    self.movieArray = tempMovieArray;
    NSMutableArray *tempKeywordArray = [[NSMutableArray alloc] init];
    self.keywordArray = tempKeywordArray;
    
    // get the last movie seen or a random movie
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"lastMovieID"]) {
        NSLog(@"LAST MOVIE STATUS: NO LASTMOVIEID, GET RANDOM");
        [Movie getRandomMovie:[appDelegate getDBPath]];
        Movie *mov = [movieArray objectAtIndex:0];
        lastMovieID = mov.mID;
        [Keywords getKeywordsForMovie:mov.mID dbPath:[appDelegate getDBPath]];
    } else {
        NSLog(@"LAST MOVIE STATUS: HAS A LASTMOVIEID OF %d",[[NSUserDefaults standardUserDefaults] integerForKey:@"lastMovieID"]);
        [Movie getMovieFromID:[[NSUserDefaults standardUserDefaults] integerForKey:@"lastMovieID"] dbPath:[appDelegate getDBPath]];
        Movie *mov = [movieArray objectAtIndex:0];
        lastMovieID = mov.mID;
        [Keywords getKeywordsForMovie:mov.mID dbPath:[appDelegate getDBPath]];
    }

    [self configureView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.keypad = nil;
    self.keywordList = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
