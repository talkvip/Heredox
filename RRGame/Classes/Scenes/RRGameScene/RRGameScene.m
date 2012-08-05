//
//  UDGameScene.m
//  RRHeredox
//
//  Created by Rolandas Razma on 7/13/12.
//  Copyright UD7 2012. All rights reserved.
//

#import "RRGameScene.h"
#import "RRGameLayer.h"
#import "RRAIPlayer.h"
#import "RRPlayer.h"


@implementation RRGameScene {
    NSUInteger _numberOfPlayers;
}


#pragma mark -
#pragma mark UDGameScene


+ (id)sceneWithGameMode:(RRGameMode)gameMode numberOfPlayers:(NSUInteger)numberOfPlayers firstPlayerColor:(RRPlayerColor)playerColor {
    return [[[self alloc] initWithGameMode:gameMode numberOfPlayers:numberOfPlayers firstPlayerColor:playerColor] autorelease];
}


- (id)initWithGameMode:(RRGameMode)gameMode numberOfPlayers:(NSUInteger)numberOfPlayers firstPlayerColor:(RRPlayerColor)playerColor {
    if( (self = [self init]) ){
        _numberOfPlayers = numberOfPlayers;
        
        RRGameLayer *gameLayer = [RRGameLayer layerWithGameMode:gameMode firstPlayerColor:playerColor];
        [gameLayer setPlayer1: [RRPlayer playerWithPlayerColor:playerColor]];

        if( numberOfPlayers == 1 ){
            RRAIPlayer *player = [RRAIPlayer playerWithPlayerColor: ((playerColor == RRPlayerColorBlack)?RRPlayerColorWhite:RRPlayerColorBlack)];
            [player setDificultyLevel: [[NSUserDefaults standardUserDefaults] integerForKey:@"RRHeredoxAILevel"]];
            
            [gameLayer setPlayer2: player];
        }

        [self addChild: gameLayer];
    }
    return self;
}


#pragma mark -
#pragma mark CCNode


- (void)onExitTransitionDidStart {
    [super onExitTransitionDidStart];
    
    [[RRHeredox sharedInstance] playEffect:@"RRSceneTransition.mp3"];
    [[RRHeredox sharedInstance] stopEffect: [NSString stringWithFormat:@"RRGameSceneNumberOfPlayers%u.mp3", _numberOfPlayers]];
}


- (void)onEnterTransitionDidFinish {
    [super onEnterTransitionDidFinish];
    [[RRHeredox sharedInstance] playEffect: [NSString stringWithFormat:@"RRGameSceneNumberOfPlayers%u.mp3", _numberOfPlayers]];
}


@end
