//
//  Game.m
//  HNH
//
//  Created by Ben Tesch on 11/29/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize gameId;
@synthesize gameTitle;
@synthesize gamePlayers;
@synthesize gamePlayersScore;
@synthesize gameMoviesDone;
@synthesize gameLastKeywordRowViewed;
@synthesize gameActive;

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:self.gameId forKey:@"GameId"];
    [aCoder encodeObject:self.gameTitle forKey:@"GameTitle"];
    [aCoder encodeObject:self.gamePlayers forKey:@"GamePlayers"];
    [aCoder encodeObject:self.gamePlayersScore forKey:@"GamePlayersScore"];
    [aCoder encodeObject:self.gameMoviesDone forKey:@"GameMoviesDone"];
    [aCoder encodeInt:self.gameLastKeywordRowViewed forKey:@"GameLastKeywordRowViewed"];
    [aCoder encodeBool:self.gameActive forKey:@"GameActive"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.gameId = [aDecoder decodeIntForKey:@"GameId"];
        self.gameTitle = [aDecoder decodeObjectForKey:@"GameTitle"];
        self.gamePlayers = [aDecoder decodeObjectForKey:@"GamePlayers"];
        self.gamePlayersScore = [aDecoder decodeObjectForKey:@"GamePlayersScore"];
        self.gameMoviesDone = [aDecoder decodeObjectForKey:@"GameMoviesDone"];
        self.gameLastKeywordRowViewed = [aDecoder decodeIntForKey:@"GameLastKeywordRowViewed"];
        self.gameActive = [aDecoder decodeBoolForKey:@"GameActive"];
    }
    return self;
}

@end
