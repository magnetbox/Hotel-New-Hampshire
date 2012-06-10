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
@synthesize randomView, randomText, helpView, helpOpacity, welcomeTitle, welcomeTitle2, welcomeFooter, helpText, helpFooterImage, helpFooter, movieView, movieButton, movieTitle;

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
        
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.title = @"Hotel New Hampshire";
    [self.navigationController setNavigationBarHidden:TRUE animated:NO];
    
    // set background image to be static
    UIView *patternView = [[UIView alloc] initWithFrame:self.tableView.frame];
    patternView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clamshell.png"]];
    patternView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.backgroundView = patternView;

    // start keyword table from bottom of view
    [self.tableView setContentInset:UIEdgeInsetsMake(self.tableView.frame.size.height-142,0,100,0)];
    
    // movie button at bottom
    movieView = [[UIView alloc] initWithFrame:CGRectMake(0,self.tableView.frame.size.height-100,self.tableView.frame.size.width,100)];
    movieView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather.png"]];    
    
    movieButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, movieView.frame.size.width, movieView.frame.size.height)];
    [movieButton addTarget:self action:@selector(scrollToNextKeyword) forControlEvents:UIControlEventTouchUpInside];
    
    movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, movieButton.frame.size.width-20.0, movieButton.frame.size.height-20.0) ];
    
    movieTitle.backgroundColor = [UIColor clearColor];
    movieTitle.textColor = [UIColor colorWithRed:230.0f/255.0f green:210.0f/255.0f blue:170.0f/255.0f alpha:1.0f];
    movieTitle.shadowColor = [UIColor colorWithRed:84.0f/255.0f green:31.0f/255.0f blue:7.0f/255.0f alpha:1.0f];
    movieTitle.shadowOffset = CGSizeMake(1,1);
    movieTitle.textAlignment = UITextAlignmentCenter;
    movieTitle.lineBreakMode = UILineBreakModeWordWrap;    
    movieTitle.numberOfLines = 3;
    
    [movieButton addSubview:movieTitle];
    [movieView addSubview:movieButton];    
    [self.navigationController.view addSubview:movieView];    
    

    // load hidden random message alert box
    randomView = [[UIView alloc] initWithFrame:CGRectMake(10,-180,self.tableView.frame.size.width-20,100)];
    randomView.hidden = YES;
    randomView.backgroundColor = [UIColor clearColor];

    randomText = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, randomView.frame.size.width-20.0, randomView.frame.size.height-20.0)];
    randomText.backgroundColor = [UIColor clearColor];
    randomText.font = [UIFont fontWithName:@"Futura Md BT" size:15.0];
    randomText.textColor = [UIColor colorWithRed:91.0f/255.0f green:130.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    randomText.shadowColor = [UIColor colorWithRed:178.0f/255.0f green:208.0f/255.0f blue:212.0f/255.0f alpha:1.0f];
    randomText.shadowOffset = CGSizeMake(1,1);
    randomText.textAlignment = UITextAlignmentCenter;
    randomText.numberOfLines = 0;
    randomText.text = @"NEW RANDOM MOVIE!";
    [randomView addSubview:randomText];
    [self.view addSubview:randomView];
    
    // help view
    helpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    helpView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clamshell.png"]];
    [self.navigationController.view addSubview:helpView];
    [self.navigationController.view bringSubviewToFront:helpView];
    
    // helpFooter image
    helpFooterImage = [[UIView alloc] initWithFrame:CGRectMake(0, helpView.frame.size.height-100.0, helpView.frame.size.width, 100.0)];
    helpFooterImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather.png"]];
    [helpView addSubview:helpFooterImage];
    
    // help opacity view
    helpOpacity = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    helpOpacity.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3f];
    [helpView addSubview:helpOpacity];
    
    // welcomeTitle text
    welcomeTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, helpView.frame.size.width, 40)];
    [welcomeTitle setFont:[UIFont fontWithName:@"Futura Md BT" size:40.0]];
    welcomeTitle.backgroundColor = [UIColor clearColor];
    welcomeTitle.textColor = [UIColor colorWithRed:245.0f/255.0f green:225.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    welcomeTitle.textAlignment = UITextAlignmentCenter;
    welcomeTitle.text = @"HOTEL NEW";
    [helpOpacity addSubview:welcomeTitle];
    welcomeTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, helpView.frame.size.width, 40)];
    [welcomeTitle2 setFont:[UIFont fontWithName:@"Futura Md BT" size:40.0]];
    welcomeTitle2.backgroundColor = [UIColor clearColor];
    welcomeTitle2.textColor = [UIColor colorWithRed:245.0f/255.0f green:225.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    welcomeTitle2.textAlignment = UITextAlignmentCenter;
    welcomeTitle2.text = @"HAMPSHIRE";
    [helpOpacity addSubview:welcomeTitle2];
    
    // welcomeFooter text
    welcomeFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 112, helpView.frame.size.width, 12)];
    [welcomeFooter setFont:[UIFont fontWithName:@"Futura Md BT" size:12.0]];
    welcomeFooter.textColor = [UIColor blackColor];
    welcomeFooter.backgroundColor = [UIColor clearColor];
    welcomeFooter.textAlignment = UITextAlignmentCenter;
    welcomeFooter.text = @"A MOVIE GUESSING GAME";
    [helpOpacity addSubview:welcomeFooter];
    
    // help text
    helpText = [[UILabel alloc] initWithFrame:CGRectMake((helpView.frame.size.width-234)/2, 142, 240, 220)];
    helpText.backgroundColor = [UIColor clearColor];
    helpText.text = @"You are given a title and a keyword: keep the title to yourself; read the keyword aloud; encourage your guests to guess the film. For another keyword, tap the title and read on.\r\n\r\nOnce the film is named, tap the keyword that gave it away to reveal another film which has the keyword in common. Begin again.\r\n\r\nTo pass on an unfamiliar title, reselect the keyword. To shake things up, shake for a random movie.\r\n\r\nPlay as you please: limit the guesses per player; pass to the guest who guessed the film; pass to your right; be your own guest. Welcome.";
    [helpText setFont:[UIFont fontWithName:@"Futura" size:9.0]];
    helpText.text = [helpText.text uppercaseString];
    helpText.lineBreakMode = UILineBreakModeWordWrap;
    helpText.numberOfLines = 0;
    [helpOpacity addSubview:helpText];
    
    // helpFooter text
    helpFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, helpView.frame.size.height-100.0, helpView.frame.size.width, 100.0) ];
    helpFooter.backgroundColor = [UIColor clearColor];
    helpFooter.font = [UIFont fontWithName:@"Futura Md BT" size:14.0];
    helpFooter.textColor = [UIColor colorWithRed:230.0f/255.0f green:210.0f/255.0f blue:170.0f/255.0f alpha:1.0f];
    helpFooter.shadowColor = [UIColor colorWithRed:84.0f/255.0f green:31.0f/255.0f blue:7.0f/255.0f alpha:1.0f];
    helpFooter.shadowOffset = CGSizeMake(1,1);
    helpFooter.textAlignment = UITextAlignmentCenter;
    helpFooter.numberOfLines = 0;
    helpFooter.text = @"TAP TO DISMISS THE HELP\r\nPINCH TO SUMMON THE HELP";
    [helpOpacity addSubview:helpFooter];

    UIPinchGestureRecognizer *pinchToToggleHelp = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(toggleHelp:)];
    [self.navigationController.view addGestureRecognizer:pinchToToggleHelp];
    
    UITapGestureRecognizer *tapToCloseHelp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeHelp:)];
    [self.helpView addGestureRecognizer:tapToCloseHelp];

    // if help has never been seen before, show it and save that it's been seen
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"seenHelp"]) {
        NSLog(@"HELP: NEVER SEEN IT");
        helpView.hidden = NO;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"seenHelp"];
        [defaults synchronize];
    } else {
        NSLog(@"HELP: SEEN IT");
        helpView.hidden = YES;
    }
    
    // set movie title
    Movie *mov = [appDelegate.movieArray objectAtIndex:0];
    [self setMovieButtonTitle:mov];
    
    [super viewDidLoad];

}

-(void)toggleHelp:(UIPinchGestureRecognizer *)sender {
    
    CGFloat lastScale = 1.0;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        lastScale = [sender scale];
    }
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGFloat pinchscale = [sender scale];
        CGFloat currentScale = 1.0 - (lastScale - pinchscale);
        
        if(currentScale<1.0 && helpView.isHidden) {

            NSLog(@"PINCH");
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [helpView setAlpha:0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [helpView setHidden:NO];
            [helpView setAlpha:1];
            [UIView commitAnimations];
            
        } else {
            
            NSLog(@"UNPINCH");
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [helpView setAlpha:1];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [helpView setHidden:YES];
            [helpView setAlpha:0];
            [UIView commitAnimations];

        }
        lastScale = [sender scale];
    }
}

-(void)closeHelp:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"TAP!");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [helpView setAlpha:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [helpView setHidden:YES];
        [helpView setAlpha:0];
        [UIView commitAnimations];
    }
}

-(void)setMovieButtonTitle:(Movie *)mov{
    
    UIFont *font = [UIFont fontWithName:@"Futura Md BT" size:24.0];
    NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", mov.mTitle, mov.mYear];
    movieString = [movieString uppercaseString];     
    
    /* Calculate the needed font size. This for loop starts at the largest font size, and decreases by two point sizes (i=i-2) until it either hits a size that will fit or hits the minimum size we want to allow (i > 10) */
    int i;
    for(i = 24; i > 10; i=i-2)
    {
        // Set the new font size.
        font = [font fontWithSize:i];
        // NSLog(@"Trying size: %u", i);
        
        /* This step is important: We make a constraint box 
         using only the fixed WIDTH of the UILabel. The height will
         be checked later. */ 
        CGSize constraintSize = CGSizeMake(260.0f, MAXFLOAT);
        
        // This step checks how tall the label would be with the desired font.
        CGSize labelSize = [movieString sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        
        /* Here is where you use the height requirement!
         Set the value in the if statement to the height of your UILabel
         If the label fits into your required height, it will break the loop
         and use that font size. */
        if(labelSize.height <= 80.0f)
            break;
    }
    // You can see what size the function is using by outputting: NSLog(@"Best size is: %u", i);
    
    // Set the UILabel's font to the newly adjusted font.
    movieTitle.font = font;
    
    // Put the text into the UILabel outlet variable.
    movieTitle.text = movieString;
    
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
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"KEYWORD TOTAL: %d",[appDelegate.keywordArray count]);
    return [appDelegate.keywordArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Customize keyword cell
    cell.textLabel.font = [UIFont fontWithName:@"Futura Md BT" size:16.0];
    cell.textLabel.textColor = [UIColor colorWithRed:245.0f/255.0f green:225.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:self.tableView.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];

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
    randomView.hidden = YES; // make random message alert go away
    
    if (appDelegate.lastKeywordRowViewed < [appDelegate.keywordArray count]-1) {
        appDelegate.lastKeywordRowViewed = appDelegate.lastKeywordRowViewed+1;
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:appDelegate.lastKeywordRowViewed inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)reloadTableView:(NSInteger)pk {

    NSLog(@"RELOAD TABLE");
    appDelegate.lastKeywordRowViewed = 0;
    [appDelegate.movieArray removeAllObjects];
    [Movie getMovieFromKeyword:pk dbPath:[appDelegate getDBPath]];

    if(appDelegate.movieArray == nil || appDelegate.movieArray.count == 0){
        NSLog(@"MOVIE TYPE: RANDOM");
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [randomView setAlpha:0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [randomView setHidden:NO];
        [randomView setAlpha:1];
        [UIView commitAnimations];
        
        NSLog(@"%d",pk);
        if (pk!=0) {
            randomText.text = [@"There are no other movies in the game based on that keyword, so a random movie has been chosen instead" uppercaseString];
        } else {
            randomText.text = @"NEW RANDOM MOVIE!";
        }

        // if a movie was not found based on that keyword, get a random movie
        [Movie getRandomMovie:[appDelegate getDBPath]];
        Movie *mov = [appDelegate.movieArray objectAtIndex:0];
        appDelegate.lastMovieID = mov.mID;
        [Keywords getKeywordsForMovie:mov.mID dbPath:[appDelegate getDBPath]];
        [self setMovieButtonTitle:mov];

    } else {
        NSLog(@"MOVIE TYPE: CONNECTED");
        randomView.hidden = YES;

        // if a movie was found based on that keyword, use it
        Movie *mov = [appDelegate.movieArray objectAtIndex:0];
        appDelegate.lastMovieID = mov.mID;
        [Keywords getKeywordsForMovie:mov.mID dbPath:[appDelegate getDBPath]];
        [self setMovieButtonTitle:mov];
    }
    
    [self.tableView reloadData];

    //scroll back to top of list
    NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];

}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	if (motion == UIEventSubtypeMotionShake)
	{
		NSLog(@"shake");
        [self reloadTableView:0];
	}
}

@end
