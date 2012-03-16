//
//  Keywords.m
//  Hotel New Hampshire
//
//  Created by Ben Tesch on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Keywords.h"

static sqlite3 *database = nil;

@implementation Keywords

@synthesize kID, kTitle;

+ (void) getKeywordsForMovie:(NSInteger)pk dbPath:(NSString *)dbPath {
    
    NSLog(@"MOVIE PK: %d",pk);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM keyword JOIN movie_keyword ON keyword.id = movie_keyword.keyword_id WHERE movie_keyword.movie_id = %d",pk];
        
        sqlite3_stmt *selectstmt;
        
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstmt, NULL) == SQLITE_OK) {            
            
            while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                Keywords *kObj = [[Keywords alloc] initWithPrimaryKey:primaryKey];                
                kObj.kTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                [appDelegate.keywordArray addObject:kObj];
            }
        }
        
    } else {
        sqlite3_close(database);
    }
}

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
    
}

+ (void) finalizeStatements {
    if(database) sqlite3_close(database);
}

- (id) initWithPrimaryKey:(NSInteger) pk {
    
    self = [super init];
    if (self != nil) {
        kID = pk;
    }    
    return self;
}

@end
