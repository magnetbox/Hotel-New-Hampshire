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
@synthesize randomMessage, randomText, helpView, helpText;

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
    
    self.title = @"Hotel New Hampshire";
    [self.navigationController setNavigationBarHidden:TRUE animated:NO];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(self.tableView.frame.size.height-142,0,0,0)];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clamshell.png"]];
    
    // load hidden random message alert box
    randomMessage = [[UIView alloc] initWithFrame:CGRectMake(10,-150,self.tableView.frame.size.width-20,100)];
    randomMessage.hidden = YES;
    randomMessage.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    randomText = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, randomMessage.frame.size.width-20.0, randomMessage.frame.size.height-20.0)];
    randomText.backgroundColor = [UIColor clearColor];
    randomText.font = [UIFont fontWithName:@"Futura-Medium" size:15.0];
    randomText.textColor = [UIColor blackColor];
    randomText.text = @"There are no other movies in the game based on that keyword, so a random movie has been chosen instead.";

    [randomText setUserInteractionEnabled:NO];
    [randomMessage setUserInteractionEnabled:NO];
    [randomMessage addSubview:randomText];
    [self.view addSubview:randomMessage];
    
    // load help box
    helpView = [[UIScrollView alloc] initWithFrame:CGRectMake(10,150-self.view.frame.size.height,self.view.frame.size.width-20,self.view.frame.size.height-20)];
    helpView.contentSize = CGSizeMake(self.view.frame.size.width, 3000);
    helpView.backgroundColor = [UIColor whiteColor];
    helpView.showsHorizontalScrollIndicator = FALSE;
    helpView.showsVerticalScrollIndicator = TRUE;
    helpView.delegate = self;
    
    helpText = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, helpView.frame.size.width-20.0, helpView.frame.size.height-20.0)];
    helpText.text = @"This is how you play the game.\r\n\r\nPinch to make the help go away.\r\nUnpinch to bring the help back.";
    
    UIPinchGestureRecognizer *pinchToHideHelp = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(hideHelp:)];
    [helpView addGestureRecognizer:pinchToHideHelp];

    UIPinchGestureRecognizer *pinchToShowHelp = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(showHelp:)];
    [self.tableView addGestureRecognizer:pinchToShowHelp];

    [helpView addSubview:helpText];
    [self.view addSubview:helpView];
    

}

-(void)hideHelp:(UIPinchGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        helpView.hidden = YES;
    }
}

-(void)showHelp:(UIPinchGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        helpView.hidden = NO;
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *movieView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,100)];
    movieView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather.png"]];    
    
    UIButton *movieButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, movieView.frame.size.width, movieView.frame.size.height)];
    [movieButton addTarget:self action:@selector(scrollToNextKeyword) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, movieButton.frame.size.width-20.0, movieButton.frame.size.height-20.0) ];
    
    movieTitle.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont fontWithName:@"Futura Md BT" size:24.0];
    movieTitle.textColor = [UIColor colorWithRed:230.0f/255.0f green:210.0f/255.0f blue:170.0f/255.0f alpha:1.0f];
    movieTitle.shadowColor = [UIColor colorWithRed:84.0f/255.0f green:31.0f/255.0f blue:7.0f/255.0f alpha:1.0f];
    movieTitle.shadowOffset = CGSizeMake(1,1);
    movieTitle.textAlignment = UITextAlignmentCenter;
    movieTitle.lineBreakMode = UILineBreakModeWordWrap;    
    movieTitle.numberOfLines = 3;
    
    Movie *mov = [appDelegate.movieArray objectAtIndex:0];
    NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", mov.mTitle, mov.mYear];
    movieString = [movieString uppercaseString];     

    /* Time to calculate the needed font size.
     This for loop starts at the largest font size, and decreases by two point sizes (i=i-2)
     Until it either hits a size that will fit or hits the minimum size we want to allow (i > 10) */
    int i;
    for(i = 24; i > 10; i=i-2)
    {
        // Set the new font size.
        font = [font fontWithSize:i];
        // You can log the size you're trying: NSLog(@"Trying size: %u", i);
        
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
        
        NSLog(@"%d",pk);
        if (pk==0) {
            randomText.text = @"NEW RANDOM MOVIE!";
            randomText.textAlignment = UITextAlignmentCenter;
        } else {
            randomText.text = @"There are no other movies in the game based on that keyword, so a random movie has been chosen instead.";
            randomText.textAlignment = UITextAlignmentLeft;
        }

        // if a movie was not found based on that keyword, get a random movie
        [Movie getRandomMovie:[appDelegate getDBPath]];
        Movie *mov = [appDelegate.movieArray objectAtIndex:0];
        appDelegate.lastMovieID = mov.mID;
        [Keywords getKeywordsForMovie:mov.mID dbPath:[appDelegate getDBPath]];

    } else {
        NSLog(@"MOVIE TYPE: CONNECTED");
        randomMessage.hidden = YES;

        // if a movie was found based on that keyword, use it
        Movie *mov = [appDelegate.movieArray objectAtIndex:0];
        appDelegate.lastMovieID = mov.mID;
        [Keywords getKeywordsForMovie:mov.mID dbPath:[appDelegate getDBPath]];
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
