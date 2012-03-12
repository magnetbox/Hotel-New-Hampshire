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
    NSInteger randomMID;
}

@property (nonatomic, assign) NSInteger mID;
@property (nonatomic, copy) NSString *mTitle;
@property (nonatomic, assign) NSInteger mYear;

+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;

@end
