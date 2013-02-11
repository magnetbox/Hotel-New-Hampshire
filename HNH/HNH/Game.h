//
//  Game.h
//  HNH
//
//  Created by Ben Tesch on 11/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject <NSCoding> {
    NSInteger gameId;
    NSString *gameTitle;
    NSArray *gamePlayers;
    NSMutableArray *gamePlayersScore;
    NSMutableArray *gameMoviesDone;
    NSInteger gameLastKeywordRowViewed;
    BOOL gameActive;
}

@property (nonatomic, assign) NSInteger gameId;
@property (nonatomic, retain) NSString *gameTitle;
@property (nonatomic, retain) NSArray *gamePlayers;
@property (nonatomic, retain) NSMutableArray *gamePlayersScore;
@property (nonatomic, retain) NSMutableArray *gameMoviesDone;
@property (nonatomic, assign) NSInteger gameLastKeywordRowViewed;
@property (nonatomic) BOOL gameActive;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
