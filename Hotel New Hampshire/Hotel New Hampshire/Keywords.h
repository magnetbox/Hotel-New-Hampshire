//
//  Keywords.h
//  Hotel New Hampshire
//
//  Created by Ben Tesch on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Keywords : NSObject {
    NSInteger kID;
    NSString *kTitle;
}

@property (nonatomic, readonly) NSInteger kID;
@property (nonatomic, retain) NSString *kTitle;

+ (Keywords*) getKeywordsForMovie:(NSInteger)pk dbPath:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;


@end
