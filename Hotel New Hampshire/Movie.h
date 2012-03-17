//
//  Movie.h
//  Hotel New Hampshire
//
//  Created by Ben Tesch on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Movie : NSObject {
    NSInteger mID;
    NSString *mTitle;
    NSInteger mYear;
}

@property (nonatomic, assign) NSInteger mID;
@property (nonatomic, retain) NSString *mTitle;
@property (nonatomic, assign) NSInteger mYear;

+ (void) getRandomMovie:(NSString *)dbPath;
+ (void) getMovieFromKeyword:(NSInteger)pk dbPath:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;

@end
