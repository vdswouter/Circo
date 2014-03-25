//
//  CBackGroundLayer.cpp
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#include "CBackGroundLayer.h"


void CBackGroundLayer::setup() {
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_NON_RETINA) {
        backgroundpicture.loadImage("images/background_4_retina.png");
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_4_RETINA) {
        backgroundpicture.loadImage("images/background_4_retina.png");
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_NON_RETINA) {
        backgroundpicture.loadImage("images/background_5_retina.png");
    }
    
    if (CPhoneDetector::detectPhone() == C_IPHONE_5_RETINA) {
        backgroundpicture.loadImage("images/background_5_retina.png");
    }
    
    
    fadeshaderin.load("shaders/FadeShader");
    fadeshaderout.load("shaders/FadeShader");
    
    bdoTransitionIn = false;
    bdoTransitionOut = false;
    
    fadeinval = 0;
    fadeoutval = 0.4;
    
    
    prev = new ofFbo();
    prev->allocate(ofGetWidth(), ofGetHeight());
    
    bandpicture.setup();
    libpicture.setup();
    twitterpicture.setup();
    
    ofAddListener(CTriggerController::getInstance()->timmerTrigger,this,&CBackGroundLayer::timerTriggerDone);
    ofAddListener(CLoadTweet::getInstance()->tweetLoaded, this, &CBackGroundLayer::tweetLoaded);
    
    bShowTwitter = false;
    bTwitterTimerReached = true;
}

void CBackGroundLayer::startWithBAndPicture() {
    bandpicture.changeImage();
    current = &bandpicture.current;
    
    prev->begin();
    current->draw(0, 0);
    prev->end();
    
    bdoTransitionIn = true;
    bdoTransitionOut = true;
    
    fadeinval = 0;
    fadeoutval = 0.4;
}

void CBackGroundLayer::update() {
    int timer = ofGetElapsedTimeMillis() - twitterStartTime;
    
    if(timer >= twitterEndTime && !bTwitterTimerReached) {
        bTwitterTimerReached = true;
        bShowTwitter = false;
    }
}

void CBackGroundLayer::draw() {
    ofEnableAlphaBlending();
    backgroundpicture.draw(0, 0,ofGetWidth(),ofGetHeight());
    if (current) {
        if (!bdoTransitionIn && !bdoTransitionOut) {
            current->draw(0, 0);
        } else {
            fadeInCurrent();
            fadeOutPrev();
        }
    }
    ofDisableAlphaBlending();
}

void CBackGroundLayer::timerTriggerDone(float &f) {
    
    if (!bShowTwitter) {
        
        prev->begin();
        current->draw(0, 0);
        prev->end();
        
        
        int decider = CRandomGen::random_in_range_int(0, 101);
        
        if (decider>30) {
            bandpicture.changeImage();
            current = &bandpicture.current;
            
        } else {
            if (libpicture.changeImage()) {
                current = &libpicture.current;
            }else {
                bandpicture.changeImage();
                current = &bandpicture.current;
            }
        }
        
        //start fade
        bdoTransitionIn = true;
        bdoTransitionOut = true;
        
        fadeinval = 0;
        fadeoutval = 0.4;
    }
}


void CBackGroundLayer::fadeInCurrent() {
    fadeinval+=0.001;
    
    if (fadeinval>=0.4) {
        bdoTransitionIn = false;
    }
    fadeshaderin.begin();
    fadeshaderin.setUniform1f("alpha", fadeinval);
    current->draw(0, 0);
    fadeshaderin.end();
}


void CBackGroundLayer::fadeOutPrev() {
    fadeoutval-=0.001;
    if (fadeoutval<=0) {
        bdoTransitionOut = false;
    }
    fadeshaderout.begin();
    fadeshaderout.setUniform1f("alpha", fadeoutval);
    prev->draw(0, 0);
    fadeshaderout.end();
}

void CBackGroundLayer::tweetLoaded(float &f) {
    twitterpicture.changeImage(CLoadTweet::getInstance()->picture);
    current = &twitterpicture.current;
    //start fade
    bShowTwitter = true;
    bTwitterTimerReached = false;
    twitterStartTime = ofGetElapsedTimeMillis();
    twitterEndTime = ofRandom(8000,12000);
}


