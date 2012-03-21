//
//  AppDelegate.h
//  Hotel New Hampshire
//
//  Created by Ben Tesch on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;
@class Keywords;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableArray *movieArray;
    NSMutableArray *keywordArray;
    NSInteger lastMovieID;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSMutableArray *movieArray;
@property (nonatomic, retain) NSMutableArray *keywordArray;
@property (nonatomic, assign) NSInteger lastMovieID;
@property (nonatomic, assign) NSInteger lastRow;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

@end
