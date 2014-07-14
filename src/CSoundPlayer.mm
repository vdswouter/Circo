//
//  CSoundPlayer.m
//  Circo
//
//  Created by Wim Vanhenden on 12/03/14.
//
//

#import "CSoundPlayer.h"
#include "CRandomGen.h"


static CSoundPlayer *sharedMyManager = nil;

@implementation CSoundPlayer

testApp *myApp;

@synthesize audioPlayer;
@synthesize introvoiceplayer;
@synthesize intermezplayer;
@synthesize thescale;
@synthesize currentsong;

#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}
+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedManager] retain];
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (id)retain {
    return self;
}
- (unsigned)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}
- (oneway void)release {
    // never release
}
- (id)autorelease {
    return self;
}
- (id)init {
    if (self = [super init]) {
        //init stuff here
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [super dealloc];
}



-(void) setup {
    currentsong = 0;
    myApp = (testApp*)ofGetAppPtr();
    interruptedOnPlayback = false;
    
    /*NSError *setCategoryError = nil;
    NSError *activationError = nil;
    [[AVAudioSession sharedInstance] setActive:YES error:&activationError];
    [[AVAudioSession sharedInstance] setDelegate:self];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    */
  
    
    //MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:@"" InDirectory:@"img" DoYouWantImageView:NO]];
    
    //dictionary met textuele data.
    /*NSDictionary *streamInfo = @{
                                 MPMediaItemPropertyTitle: @"Klara Overal Livestream",
                                 MPMediaItemPropertyArtist: @"Klara",
                                 MPMediaItemPropertyAlbumTitle: @"Klara Overal",
                                 MPMediaItemPropertyAlbumArtist: @"Klara",
                                 };*/
    
    //data sturen naar even.
    //[[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:streamInfo];
    

}


-(void)playIntroVoice {
    NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource:@"sound/circo_voice_intro" withExtension:@"mp3"];
    
    AVAudioPlayer * newAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:NULL];
    self.introvoiceplayer = newAudio;
    
    [introvoiceplayer release]; // release the audio safely
    
    introvoiceplayer.delegate = self;
    [introvoiceplayer setMeteringEnabled:true];
    [introvoiceplayer prepareToPlay];
    [introvoiceplayer setNumberOfLoops:0];
    [introvoiceplayer play];
}

-(void) playSongWithid:(int)incid {
    
    fireonethirdofthesong = false;
    firemiddleofthesong = false;
    firethreefourthofthesong = false;
    
    currentsong = incid;
    
    [[CPersistantData sharedManager] setCurrentsong:currentsong];
    [[CPersistantData sharedManager] saveData];
    
    CVisualizer::getInstance()->songChanged();
    CSongTitleScreen::getInstance()->songChanged();
    
    NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource: [[[OBJCDataModel sharedManager] songs] objectAtIndex:incid] withExtension:@"mp3"];
    
    AVAudioPlayer * newAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:NULL];
    self.audioPlayer = newAudio;
    
    //self.audioPlayer.volume = 0;
    
    [audioPlayer release]; // release the audio safely
    audioPlayer.delegate = self;
    [audioPlayer setMeteringEnabled:true];
    [audioPlayer prepareToPlay];
    [audioPlayer setNumberOfLoops:0];
    [audioPlayer play];
    
    int rand = CRandomGen::random_in_range_int(0, 101);
    doFade = false;
    
    if (rand>80) {
        int randommez = CRandomGen::random_in_range_int(0,[[[OBJCDataModel sharedManager] intermez] count]);
        
        NSURL *audioFileURLMez = [[NSBundle mainBundle] URLForResource: [[[OBJCDataModel sharedManager] intermez] objectAtIndex:randommez] withExtension:@"mp3"];
        
        AVAudioPlayer * newAudioMez=[[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURLMez error:NULL];
        self.intermezplayer = newAudioMez;
        
        [intermezplayer release]; // release the audio safely
        intermezplayer.delegate = self;
        [intermezplayer setMeteringEnabled:false];
        [intermezplayer prepareToPlay];
        [intermezplayer setNumberOfLoops:0];
        [intermezplayer play];
        
        self.audioPlayer.volume = 0.2;
        
        fader=0.2;
        
    }
}

-(void) update {
    
    if (doFade) {
        fader+=0.01;
        
         [[self audioPlayer ] setVolume:fader];
        
        if (fader>=1.0) {
            fader=1.0;
            doFade = false;
        }
    }
    
    thescale = 0;
    
    if (audioPlayer.playing ) {
        
        //cout<<[audioPlayer currentTime]<<" "<<[audioPlayer duration]<<endl;
        
        if ([audioPlayer currentTime]>[audioPlayer duration]*0.3-3 && [audioPlayer currentTime]<([audioPlayer duration]*0.3+3)) {
           
            if (!fireonethirdofthesong) {
                fireonethirdofthesong = true;
                CSongTitleScreen::getInstance()->songChanged();
            }
        }
        
        
        if ([audioPlayer currentTime]>[audioPlayer duration]*0.5-3 && [audioPlayer currentTime]<([audioPlayer duration]*0.5+3)) {
            
            if (!firemiddleofthesong) {
                firemiddleofthesong = true;
                CSongTitleScreen::getInstance()->songChanged();
            }
            
        }
        
        if ([audioPlayer currentTime]>[audioPlayer duration]*0.7-3 && [audioPlayer currentTime]<([audioPlayer duration]*0.7+3)) {
            
            if (!firethreefourthofthesong) {
                firethreefourthofthesong = true;
                CSongTitleScreen::getInstance()->songChanged();
            }
            
        }
        
        
        [audioPlayer updateMeters];
        
        float power = 0.0f;
        for (int i = 0; i < [audioPlayer numberOfChannels]; i++) {
            power += [audioPlayer averagePowerForChannel:i];
        }
        power /= [audioPlayer numberOfChannels];
        thescale = meterTable.ValueAt(power);
        
    }
    
    
    if (introvoiceplayer.playing) {
        [introvoiceplayer updateMeters];
        
        float power = 0.0f;
        for (int i = 0; i < [introvoiceplayer numberOfChannels]; i++) {
            power += [introvoiceplayer averagePowerForChannel:i];
        }
        power /= [introvoiceplayer numberOfChannels];
    
        thescale = meterTable.ValueAt(power);
    }
    
}

-(void) playNextSong {
    currentsong ++;
    
    if (currentsong>9) {
        currentsong =0;
    }
    
    [[CPersistantData sharedManager] setCurrentsong:currentsong];
    [[CPersistantData sharedManager] saveData];
    [self playSongWithid:currentsong];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    if (player == introvoiceplayer) {
        myApp->introvoicedone();
    }
    
    if (player == audioPlayer) {
        [self  playNextSong];
    }
    
    if (player == intermezplayer) {
        doFade = true;
    }
}

- (void) audioPlayerBeginInterruption: (AVAudioPlayer *) player {
        interruptedOnPlayback = true;
}

- (void) audioPlayerEndInterruption: (AVAudioPlayer *) player {
    
    if (interruptedOnPlayback) {
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        interruptedOnPlayback = false;
    }
}


- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    
    cout<<"recievedremotecontroleldevent"<<endl;
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [audioPlayer play];
                break;
            case UIEventSubtypeRemoteControlPause:
                [audioPlayer pause];
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                
                break;
            default:
                break;
        }
    }
}


@end