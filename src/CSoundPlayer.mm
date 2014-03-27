//
//  CSoundPlayer.m
//  Circo
//
//  Created by Wim Vanhenden on 12/03/14.
//
//

#import "CSoundPlayer.h"



static CSoundPlayer *sharedMyManager = nil;

@implementation CSoundPlayer

testApp *myApp;

@synthesize audioPlayer;
@synthesize introvoiceplayer;
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
    /*NSError *setCategoryError = nil;
    NSError *activationError = nil;
    [[AVAudioSession sharedInstance] setActive:YES error:&activationError];
    [[AVAudioSession sharedInstance] setDelegate:self];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    myApp = (testApp*)ofGetAppPtr();*/
}


-(void)playIntroVoice {
    NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource:@"sound/circo_voice_intro" withExtension:@"aiff"];
    
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
}

-(void) update {
    
    thescale = 0;
    
    if (audioPlayer.playing ) {
        
        //cout<<[audioPlayer currentTime]<<" "<<[audioPlayer duration]<<endl;
        
        if ([audioPlayer currentTime]>[audioPlayer duration]*0.3 && [audioPlayer currentTime]<([audioPlayer duration]*0.3+1)) {
           
            if (!fireonethirdofthesong) {
                fireonethirdofthesong = true;
                CSongTitleScreen::getInstance()->songChanged();
            }
        }
        
        
        if ([audioPlayer currentTime]>[audioPlayer duration]*0.5 && [audioPlayer currentTime]<([audioPlayer duration]*0.5+1)) {
            
            if (!firemiddleofthesong) {
                firemiddleofthesong = true;
                CSongTitleScreen::getInstance()->songChanged();
            }
            
        }
        
        if ([audioPlayer currentTime]>[audioPlayer duration]*0.7 && [audioPlayer currentTime]<([audioPlayer duration]*0.7+1)) {
            
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