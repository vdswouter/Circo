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
    
    ofAddListener(CTriggerController::getInstance()->timmerTrigger,this,&CBackGroundLayer::timerTriggerDone);
    ofAddListener(CLoadTweet::getInstance()->tweetLoaded, this, &CBackGroundLayer::tweetLoaded);
    
    bShowTwitter = false;
    bTwitterTimerReached = true;
    
    containerA.setup();
    containerB.setup();
}

void CBackGroundLayer::startWithBAndPicture() {
    containerA.startFadeIn();
}

void CBackGroundLayer::update() {
    int timer = ofGetElapsedTimeMillis() - twitterStartTime;
    
    if(timer >= twitterEndTime && !bTwitterTimerReached) {
        bTwitterTimerReached = true;
        bShowTwitter = false;
    }
    
    containerA.update();
    containerB.update();
   
}

void CBackGroundLayer::draw() {
    ofEnableAlphaBlending();
    backgroundpicture.draw(0, 0, ofGetWidth(), ofGetHeight());
    containerA.draw();
    containerB.draw();
    ofDisableAlphaBlending();
}

void CBackGroundLayer::timerTriggerDone(float &f) {
    if (!bShowTwitter) {
        if (containerA.bisActive) {
            containerA.startFadeOut();
            containerB.startFadeIn();
        } else {
            containerB.startFadeOut();
            containerA.startFadeIn();
        }
    }
}

void CBackGroundLayer::tweetLoaded(float &f) {
    if (containerA.bisActive) {
        containerA.insertTweetPicture(CLoadTweet::getInstance()->picture);
       
    } else {
        containerB.insertTweetPicture(CLoadTweet::getInstance()->picture);
    }
    
    bShowTwitter = true;
    
    bTwitterTimerReached = false;
    twitterStartTime = ofGetElapsedTimeMillis();
    twitterEndTime = ofRandom(8000,12000);
    
}
