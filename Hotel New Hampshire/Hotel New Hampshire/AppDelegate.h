//
//  AppDelegate.h
//  Hotel New Hampshire
//
//  Created by Ben Tesch on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableArray *movieArray;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSMutableArray *movieArray;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

@end
