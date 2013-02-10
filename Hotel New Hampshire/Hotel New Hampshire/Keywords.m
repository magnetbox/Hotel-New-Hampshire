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

+ (NSMutableArray*) getKeywordsForMovie:(NSInteger)pk dbPath:(NSString *)dbPath {
    
    //NSLog(@"MOVIE PK: %d",pk);
    NSMutableArray *keywordArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM keyword JOIN movie_keyword ON keyword.id = movie_keyword.keyword_id WHERE movie_keyword.movie_id = %d ORDER BY RANDOM()",pk];
        
        sqlite3_stmt *selectstmt;
        
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstmt, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                Keywords *kObj = [[Keywords alloc] initWithPrimaryKey:primaryKey];                
                kObj.kTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                /*
                if ([kObj.kTitle isEqualToString:appDelegate.lastKeywordSelected]) {
                    [appDelegate.keywordArray insertObject:kObj atIndex:0];
                } else {
                    [appDelegate.keywordArray addObject:kObj];
                }
                 */
                [keywordArray addObject:kObj];
            }
        }
        
    } else {
        sqlite3_close(database);
    }
    return keywordArray;
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
