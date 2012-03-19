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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Movie *mov = [appDelegate.movieArray objectAtIndex:0];
    NSString* movieString = [NSString stringWithFormat:@"%@ (%d)", mov.mTitle, mov.mYear];
    self.title = movieString;
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
    Keywords *kObj = [appDelegate.keywordArray objectAtIndex:indexPath.row];
    NSString* keywordString = [NSString stringWithFormat:@"%@", kObj.kTitle];
    cell.textLabel.text = [keywordString stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    
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
