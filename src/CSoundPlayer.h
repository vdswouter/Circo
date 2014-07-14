//
//  CSoundPlayer.h
//  Circo
//
//  Created by Wim Vanhenden on 12/03/14.
//
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "OBJCDataModel.h"

#include "ofMain.h"
#include "testApp.h"
#include "CVisualizer.h"
#include "CSongTitleScreen.h"

#import "MeterTable.h"


@interface CSoundPlayer : NSObject  <AVAudioPlayerDelegate,AVAudioSessionDelegate>{
    AVAudioPlayer *audioPlayer;
    
    AVAudioPlayer *introvoiceplayer;
    
    AVAudioPlayer *intermezplayer;
    
    int currentsong;
    
    MeterTable meterTable;
    
    float thescale;
    
    float fader;
    bool doFade;
    
    bool fireonethirdofthesong;
    bool firemiddleofthesong;
    bool firethreefourthofthesong;
    
    bool  interruptedOnPlayback;
}



+ (id)sharedManager;


- (void) playIntroVoice;

- (void) playSongWithid:(int)incid;

- (void) playNextSong;

- (void) update;


@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) AVAudioPlayer *introvoiceplayer;
@property (nonatomic, retain) AVAudioPlayer *intermezplayer;
@property int currentsong;

@property float thescale;

@end