//
//  MasterViewController.m
//  Hotel New Hampshire
//
//  Created by Ben Tesch on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "Movie.h"
#import "Keywords.h"

@implementation MasterViewController
@synthesize randomMessage;

- (void)awakeFromNib
{
    [super awakeFromNib];
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
    
    /*
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(countUp:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
     */
    
    [self.navigationController setNavigationBarHidden:TRUE];
    [self.tableView setContentInset:UIEdgeInsetsMake(self.tableView.frame.size.height-150,0,0,0)];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clamshell.png"]];
    
    randomMessage = [[UIView alloc] initWithFrame:CGRectMake(10,-150,self.tableView.frame.size.width-20,100)];
    randomMessage.hidden = YES;
    randomMessage.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    UITextView *randomText = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, randomMessage.frame.size.width-20.0, randomMessage.frame.size.height-20.0)];
    randomText.backgroundColor = [UIColor clearColor];
    randomText.font = [UIFont fontWithName:@"Futura-Medium" size:15.0];
    randomText.textColor = [UIColor blackColor];
    randomText.text = @"There are no other movies in the game based on that keyword, so a random movie has been chosen instead.";
    [randomText setUserInteractionEnabled:NO];
    [randomMessage setUserInteractionEnabled:NO];
    [randomMessage addSubview:randomText];
    [self.view addSubview:randomMessage];    
}

- (void) countUp:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"get gesture");
    NSLog(@"%d",recognizer.direction);
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"get gesture up");
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"get gesture Left");
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"KEYWORD TOTAL: %d",[appDelegate.keywordArray count]);
    return [appDelegate.keywordArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    //UIView *movieView = [[UIView alloc] initWithFrame:CGRectMake(0, 320, 350, 100)];
    UIView *movieView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,100)];
    movieView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather.png"]];    
    
    UIButton *movieButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, movieView.frame.size.width, movieView.frame.size.height)];
    [movieButton addTarget:self action:@selector(scrollToNextKeyword) forControlEvents:UIControlEventTouchUpInside];
    
    //UILabel *movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 320, 80)];
    UILabel *movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, movieView.frame.size.width-20.0, movieView.frame.size.height-20.0)];
    
    movieTitle.backgroundColor = [UIColor clearColor];
    movieTitle.font = [UIFont fontWithName:@"Futura Md BT" size:24.0];
    movieTitle.textColor = [UIColor colorWithRed:255.0f/255.0f green:180.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
    movieTitle.textAlignment = UITextAlignmentCenter;
    movieTitle.lineBreakMode = UILineBreakModeWordWrap;    
    movieTitle.numberOfLines = 2;
    
    Movie *mov = [appDelegate.movieArray objectAtIndex:0];
    NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", mov.mTitle, mov.mYear];
    movieString = [movieString uppercaseString];     
    movieTitle.text = movieString;
    
    [movieButton addSubview:movieTitle];
    [movieView addSubview:movieButton];    
    return movieView;    
}

- (float) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {    
    return  100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Customize keyword cell
    cell.textLabel.font = [UIFont fontWithName:@"Futura Md BT" size:16.0];
    cell.textLabel.textColor = [UIColor colorWithRed:245.0f/255.0f green:225.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;

    Keywords *kObj = [appDelegate.keywordArray objectAtIndex:indexPath.row];
    NSString* keywordString = [NSString stringWithFormat:@"%@", kObj.kTitle];
    keywordString = [keywordString stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    keywordString = [keywordString uppercaseString];    
    cell.textLabel.text = keywordString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Keywords *kObj = [appDelegate.keywordArray objectAtIndex:indexPath.row];
    NSLog(@"KEYWORD CLICKED: %@",kObj.kTitle);
    appDelegate.lastKeywordSelected = kObj.kTitle;
    [self reloadTableView:kObj.kID];
}

- (void)scrollToNextKeyword {
    //NSLog(@"%d of %d",appDelegate.lastKeywordRowViewed,[appDelegate.keywordArray count]);
    randomMessage.hidden = YES; // make random message alert go away
    
    if (appDelegate.lastKeywordRowViewed < [appDelegate.keywordArray count]-1) {
        appDelegate.lastKeywordRowViewed = appDelegate.lastKeywordRowViewed+1;
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:appDelegate.lastKeywordRowViewed inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)reloadTableView:(NSInteger)pk {

    appDelegate.lastKeywordRowViewed = 0;
    [appDelegate.movieArray removeAllObjects];
    [Movie getMovieFromKeyword:pk dbPath:[appDelegate getDBPath]];

    if(appDelegate.movieArray == nil || appDelegate.movieArray.count == 0){
        NSLog(@"MOVIE TYPE: RANDOM");
        randomMessage.hidden = NO;

        // if a movie was not found based on that keyword, get a random movie
        [Movie getRandomMovie:[appDelegate getDBPath]];
        Movie *mov = [appDelegate.movieArray objectAtIndex:0];
        appDelegate.lastMovieID = mov.mID;
        [Keywords getKeywordsForMovie:mov.mID dbPath:[appDelegate getDBPath]];
        NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", mov.mTitle, mov.mYear];
        self.title = movieString;

    } else {
        NSLog(@"MOVIE TYPE: CONNECTED");
        randomMessage.hidden = YES;

        // if a movie was found based on that keyword, use it
        Movie *mov = [appDelegate.movieArray objectAtIndex:0];
        appDelegate.lastMovieID = mov.mID;
        [Keywords getKeywordsForMovie:mov.mID dbPath:[appDelegate getDBPath]];
        NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", mov.mTitle, mov.mYear];
        self.title = movieString;
    }
    
    [self.tableView reloadData];

    //scroll back to top of list
    NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];

}

@end
