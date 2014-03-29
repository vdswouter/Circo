//
//  CNavigationView.cpp
//  Circo
//
//  Created by Wim Vanhenden on 19/03/14.
//
//

#include "CTrackView.h"
#import "CSoundPlayer.h"


void CTrackView::startTimer(float time) {
    starttime = ofGetElapsedTimeMillis();
    endtime = time;
    bTimerReached = false;
    bTimerIsRunning  =true;
    
}

void CTrackView::stopTimer() {
    bTimerReached = true;
    bTimerIsRunning  =false;
}


void CTrackView::setHitAreasIphone4NonRetina() {
    
    sam.x = 140/2;
    sam.y = 238/2;
    
    nightfever.x = 140/2;
    nightfever.y = 312/2;
    
    rejected.x = 140/2;
    rejected.y = 386/2;
    
    onebyone.x = 140/2;
    onebyone.y = 460/2;
    
    neverwanted.x = 140/2;
    neverwanted.y = 534/2;
    
    dragonking.x = 572/2;
    dragonking.y = 238/2;
    
    crazynights.x = 572/2;
    crazynights.y = 312/2;
    
    broken.x = 572/2;
    broken.y = 386/2;
    
    quijesuis.x = 572/2;
    quijesuis.y = 460/2;
    
    ambassador.x = 572/2;
    ambassador.y = 534/2;
    
    closecross.x = 33/2;
    closecross.y = 17/2;
    
    
}

void CTrackView::setHitAreasIphone5NonRetina() {
    
    sam.x = 238/2;
    sam.y = 238/2;
    
    nightfever.x = 238/2;
    nightfever.y = 312/2;
    
    rejected.x = 238/2;
    rejected.y = 386/2;
    
    onebyone.x = 238/2;
    onebyone.y = 460/2;
    
    neverwanted.x = 238/2;
    neverwanted.y = 534/2;
    
    dragonking.x = 669/2;
    dragonking.y = 238/2;
    
    crazynights.x = 669/2;
    crazynights.y = 312/2;
    
    broken.x = 669/2;
    broken.y = 386/2;
    
    quijesuis.x = 669/2;
    quijesuis.y = 460/2;
    
    ambassador.x = 669/2;
    ambassador.y = 534/2;
    
    closecross.x = 33/2;
    closecross.y = 17/2;
    
    
}


void CTrackView::setup() {
    
    float width = 252;
    float height = 56;
    
    onebyone = ofRectangle(0, 0, width/2,height/2);
    crazynights = ofRectangle(0, 0, width/2,height/2);
    nightfever = ofRectangle(0, 0, width/2,height/2);
    sam = ofRectangle(0, 0, width/2,60/2);
    rejected = ofRectangle(0, 0, width/2,height/2);
    dragonking = ofRectangle(0, 0, width/2,height/2);
    broken = ofRectangle(0, 0, width/2,height/2);
    ambassador = ofRectangle(0, 0, width/2,height/2);
    quijesuis = ofRectangle(0, 0, width/2,height/2);
    neverwanted = ofRectangle(0, 0, width/2,height/2);
    closecross = ofRectangle(0,0,90/2,90/2);
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_NON_RETINA) {
        image.loadImage("images/trackscreen_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_RETINA) {
        image.loadImage("images/trackscreen_4_retina.png");
        setHitAreasIphone4NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_NON_RETINA) {
        image.loadImage("images/trackscreen_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_RETINA) {
        image.loadImage("images/trackscreen_5_retina.png");
        setHitAreasIphone5NonRetina();
    }
    
    fadein = true;
    fadeval = 0.0f;
    fadeout = false;
    
    star.loadImage("images/starvote.png");
    
    timertime = 5000.0f;
    startTimer(timertime);
}

void CTrackView::update() {
    if (bTimerIsRunning) {
        
        int timer = ofGetElapsedTimeMillis() - starttime;
        if(timer >= endtime && !bTimerReached) {
            bTimerReached = true;
            bTimerIsRunning = false;
            startFadeOut();
        }
    }
}

void CTrackView::draw() {
    
    ofEnableAlphaBlending();
    if (fadein) {
        ofSetColor(255, 255, 254, fadeval);
        
        fadeval+=CDataModel::getInstance()->screenfadestep;
        
        if (fadeval>=255) {
            ofRegisterTouchEvents(this);
            fadeval= 255;
            fadein = false;
            float f=1.0f;
            ofNotifyEvent(viewReady, f, this);
        }
    }
    
    if (fadeout) {
        ofSetColor(255, 255, 254, fadeval);
        fadeval -=CDataModel::getInstance()->screenfadestep;
        if (fadeval<=0) {
            fadeval= 0;
            fadeout = false;
            ofUnregisterTouchEvents(this);
            float f=1.0f;
            ofNotifyEvent(removeView, f, this);
        }
    }
    
    image.draw(0, 0, ofGetWidth(),ofGetHeight());
    
    ofSetColor(255, 255, 254, fadeval);
    
    for (int i=0;i<CDataModel::getInstance()->songreferences.size();++i) {
        
        string incoming =CDataModel::getInstance()->songreferences[[[CSoundPlayer sharedManager] currentsong]];
        
        if (incoming=="sam") {
            star.draw(sam.x-(65/2), sam.y-6, 65/2,60/2);
        }
        
        if (incoming=="nightfever") {
            star.draw(nightfever.x-(65/2), nightfever.y-6, 65/2,60/2);
        }
        
        if (incoming=="rejected") {
            star.draw(rejected.x-(65/2), rejected.y-6, 65/2,60/2);
        }
        
        if (incoming=="onebyone") {
            star.draw(onebyone.x-(65/2), onebyone.y-6, 65/2,60/2);
        }
        
        if (incoming=="neverwanted") {
            star.draw(neverwanted.x-(65/2), neverwanted.y-6, 65/2,60/2);
        }
        
        if (incoming=="dragonking") {
            star.draw(dragonking.x-(65/2), dragonking.y-6, 65/2,60/2);
        }
        
        if (incoming=="crazynights") {
            star.draw(crazynights.x-(65/2), crazynights.y-6, 65/2,60/2);
        }
        
        if (incoming=="broken") {
            star.draw(broken.x-(65/2), broken.y-6, 65/2,60/2);
        }
        
        if (incoming=="quijesuis") {
            star.draw(quijesuis.x-(65/2), quijesuis.y-6, 65/2,60/2);
        }
        
        if (incoming=="ambassador") {
            star.draw(ambassador.x-(65/2), ambassador.y-6, 65/2,60/2);
        }
    }
    
    ofDisableAlphaBlending();
    
    ofSetColor(255, 255, 255,255);
    
}


void CTrackView::touchDown(ofTouchEventArgs & touch) {
    
    if(sam.inside(touch.x, touch.y)) {
        [[CSoundPlayer sharedManager]playSongWithid:0];
        startFadeOut();
        
    } else if (nightfever.inside(touch.x, touch.y)) {
        [[CSoundPlayer sharedManager]playSongWithid:1];
       startFadeOut();
        
    } else if (rejected.inside(touch.x, touch.y)) {
        [[CSoundPlayer sharedManager]playSongWithid:2];
        startFadeOut();
        
    } else if (onebyone.inside(touch.x, touch.y)) {
        [[CSoundPlayer sharedManager]playSongWithid:3];
        startFadeOut();
        
    } else if (neverwanted.inside(touch.x, touch.y)) {
        [[CSoundPlayer sharedManager]playSongWithid:4];
       startFadeOut();
        
    } else if (dragonking.inside(touch.x, touch.y)) {
        [[CSoundPlayer sharedManager]playSongWithid:5];
       startFadeOut();
        
    } else if (crazynights.inside(touch.x, touch.y)) {
        [[CSoundPlayer sharedManager]playSongWithid:6];
       startFadeOut();
        
    } else if (broken.inside(touch.x, touch.y)) {
        [[CSoundPlayer sharedManager]playSongWithid:7];
        startFadeOut();
        
    } else if (quijesuis.inside(touch.x, touch.y)) {
        [[CSoundPlayer sharedManager]playSongWithid:8];
        startFadeOut();
        
    } else if (ambassador.inside(touch.x, touch.y)) {
        [[CSoundPlayer sharedManager]playSongWithid:9];
       startFadeOut();
        
    } else if (closecross.inside(touch.x, touch.y)) {
        startFadeOut();
    }
}


void CTrackView::startFadeOut() {
    if (!fadeout) {
        stopTimer();
        fadeout = true;
    }
}

void CTrackView::touchMoved(ofTouchEventArgs & touch) {
    
}
void CTrackView::touchUp(ofTouchEventArgs & touch) {
    
}
void CTrackView::touchDoubleTap(ofTouchEventArgs & touch) {
    
}
void CTrackView::touchCancelled(ofTouchEventArgs & touch) {
    
}