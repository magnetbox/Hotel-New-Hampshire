//
//  Movie.m
//  Hotel New Hampshire
//
//  Created by Ben Tesch on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Movie.h"

static sqlite3 *database = nil;

@implementation Movie

@synthesize mID, mTitle, mYear;

+ (void) getMovieFromKeyword:(NSInteger)pk dbPath:(NSString *)dbPath {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM title WHERE movie_id = %d",pk];
        sqlite3_stmt *selectstmt;
        
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstmt, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                Movie *movieObj = [[Movie alloc] initWithPrimaryKey:primaryKey];
                movieObj.mTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                movieObj.mYear = sqlite3_column_int(selectstmt, 2);
                NSLog(@"MOVIE TITLE: %@",movieObj.mTitle);
                
                [appDelegate.movieArray addObject:movieObj];
            }
        }
    } else {
        sqlite3_close(database);
    }
}

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        const char *sql = "SELECT * FROM title ORDER BY RANDOM() LIMIT 1";
        sqlite3_stmt *selectstmt;
        
        if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                Movie *movieObj = [[Movie alloc] initWithPrimaryKey:primaryKey];
                movieObj.mTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                movieObj.mYear = sqlite3_column_int(selectstmt, 2);
                NSLog(@"%@",movieObj.mTitle);

                [appDelegate.movieArray addObject:movieObj];
            }
        }
    } else {
        sqlite3_close(database);
    }
}

+ (void) finalizeStatements {
    if(database) sqlite3_close(database);
}

- (id) initWithPrimaryKey:(NSInteger) pk {
    
    self = [super init];
    if (self != nil) {
        mID = pk;
    }    
    return self;
}

@end
