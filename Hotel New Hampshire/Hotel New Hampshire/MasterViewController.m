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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clamshell.png"]];
    
    UIView *movieView = [[UIView alloc] initWithFrame:CGRectMake(0, 320, 350, 100)];
    movieView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather.png"]];
    
    UILabel *movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 320, 80)];
    movieTitle.backgroundColor = [UIColor clearColor];
    movieTitle.font = [UIFont fontWithName:@"Futura-Medium" size:16.0];
    movieTitle.textColor = [UIColor whiteColor];
    movieTitle.lineBreakMode = UILineBreakModeWordWrap;    
    movieTitle.numberOfLines = 2;
    
    Movie *mov = [appDelegate.movieArray objectAtIndex:0];
    NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", mov.mTitle, mov.mYear];
    self.title = movieString;

    movieTitle.text = movieString;
    [movieView addSubview:movieTitle];
    [self.view addSubview:movieView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView setContentOffset:CGPointMake(0,-300) animated:NO];

    Movie *mov = [appDelegate.movieArray objectAtIndex:0];
    NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", mov.mTitle, mov.mYear];
    self.title = movieString;

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
    NSLog(@"# OF KEYWORDS: %d",[appDelegate.keywordArray count]);
    return [appDelegate.keywordArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // See if there's an existing cell we can reuse
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        // No cell to reuse => create a new one
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        // Initialize cell
        // TODO: Any other initialization that applies to all cells of this type.
    }
    
    /*
    // Customize movie cell
    Movie *movieObj = [appDelegate.movieArray objectAtIndex:indexPath.row];
    NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", movieObj.mTitle, movieObj.mYear];
    cell.textLabel.text = movieString;
    */
    
    // Customize keyword cell
    cell.textLabel.font = [UIFont fontWithName:@"Futura-Medium" size:16.0];
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
    [self reloadTableView:kObj.kID];

    /*
    [Movie getMovieFromKeyword:kObj.kID dbPath:appDelegate.getDBPath];
    if (appDelegate.movieArray) {
        Movie *mov = [appDelegate.movieArray objectAtIndex:0];
        appDelegate.lastMovieID = mov.mID;
    } else {
        [Movie getRandomMovie:[appDelegate getDBPath]];
        Movie *mov = [appDelegate.movieArray objectAtIndex:0];
    }
    appDelegate.lastMovieID = mov.mID;
    [Keywords getKeywordsForMovie:mov.mID dbPath:[self getDBPath]];
    */

}

- (void)reloadTableView:(NSInteger)pk {

    [appDelegate.movieArray removeAllObjects];
    [Movie getMovieFromKeyword:pk dbPath:[appDelegate getDBPath]];

    if(appDelegate.movieArray == nil || appDelegate.movieArray.count == 0){
        NSLog(@"NO MOVIE, NEED TO GET RANDOM");
        // if a movie was not found based on that keyword, get a random movie
        [Movie getRandomMovie:[appDelegate getDBPath]];
        Movie *mov = [appDelegate.movieArray objectAtIndex:0];
        appDelegate.lastMovieID = mov.mID;
        [Keywords getKeywordsForMovie:mov.mID dbPath:[appDelegate getDBPath]];
        NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", mov.mTitle, mov.mYear];
        self.title = movieString;
    } else {
        NSLog(@"FOUND A MOVIE");
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
