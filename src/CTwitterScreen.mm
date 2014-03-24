//
//  CTwitterScreen.cpp
//  Circo
//
//  Created by Wim Vanhenden on 20/03/14.
//
//

#include "CTwitterScreen.h"
#include "CRandomGen.h"


void CTwitterScreen::setup() {
    //Set up slit render
    slitrender.allocate(ofGetWidth(),ofGetHeight());
    slitrender.begin();
    ofClear(0, 0, 0,255);
    slitrender.end();
    
    //set up slit scan shader
    slitscanshader.load("shaders/SlitScanShader");
    
    //Set convergence slit render
    convergencefbo.allocate(ofGetWidth(),ofGetHeight());
    convergencefbo.begin();
    ofClear(0, 0, 0,255);
    convergencefbo.end();
    
    //set up convergence shader
    convergenceshader.load("shaders/convergence");
    
    bones.loadImage("images/bones.png");
    
    tweetxpos = 0;
    
    startTime = ofGetElapsedTimeMillis();
    endTime = ofRandom(9000,13000);
    
    ofAddListener(CLoadTweet::getInstance()->tweetLoaded, this, &CTwitterScreen::tweetLoaded);
    ofAddListener(CLoadTweet::getInstance()->tweetNotLoaded, this, &CTwitterScreen::tweetNotLoaded);
    CLoadTweet::getInstance()->loadTweet();
    
}

void CTwitterScreen::update(ofFbo &incomingfbo) {
        int timer = ofGetElapsedTimeMillis() - startTime;
        if(timer >= endTime && !bTimerReached) {
            bTimerReached = true;
            float f = 0;
            ofNotifyEvent(twitterScreenDone,f,this);
        }
    
    static int step = ofRandom(2,10);
    if (ofGetFrameNum() % step == 0){
        step = ofRandom(3,20);
        val3 = ofRandom(0,0.03);
    }
    
    convergencefbo.begin();
    
    convergenceshader.begin();
    convergenceshader.setUniform1f("rand", ofRandom(0.01,0.19));
    incomingfbo.draw(0, 0);
    convergenceshader.end();
    
    convergencefbo.end();
    
    slitrender.begin();
    slitscanshader.begin();
    slitscanshader.setUniform1f("val3", val3);
    slitscanshader.setUniform1f("xory", 1);
    convergencefbo.draw(0, 0);
    slitscanshader.end();
    slitrender.end();

    
}

void CTwitterScreen::draw() {
    
    
    slitrender.draw(0, 0);
    
    ofRectangle rect = NCFontController::getInstance()->nanum30.getStringBoundingBox("ALERT! TRENDING TWEET..."+CLoadTweet::getInstance()->message+" by "+CLoadTweet::getInstance()->user,0, 0);
    tweetxpos+=4;
    if (tweetxpos>ofGetWidth()+rect.width) {
        tweetxpos = 0;
    }

    
    static int steptwo = ofRandom(1,3);
    
    if (ofGetFrameNum() % steptwo == 0){
        
        ofSetColor(252,203, 0);
        ofRect(ofGetWidth()-tweetxpos, 22, rect.width,rect.height);
        
        ofSetColor(241,90, 125);
        NCFontController::getInstance()->nanum30.drawString("ALERT! TRENDING TWEET..."+CLoadTweet::getInstance()->message+" by "+CLoadTweet::getInstance()->user, ofGetWidth()-tweetxpos, rect.height+20);
        ofSetColor(255, 255, 255);
        
        steptwo = ofRandom(1,3);
        ofEnableAlphaBlending();
        bones.draw(ofGetWidth()-bones.width+(bones.width/2), ofGetHeight()-bones.height, bones.width,bones.height);
        ofDisableAlphaBlending();
    }
}


void CTwitterScreen::tweetLoaded(float &f) {
    ofRemoveListener(CLoadTweet::getInstance()->tweetLoaded, this, &CTwitterScreen::tweetLoaded);
    ofRemoveListener(CLoadTweet::getInstance()->tweetNotLoaded, this, &CTwitterScreen::tweetNotLoaded);
}


void CTwitterScreen::tweetNotLoaded(float &f) {
    ofRemoveListener(CLoadTweet::getInstance()->tweetLoaded, this, &CTwitterScreen::tweetLoaded);
    ofRemoveListener(CLoadTweet::getInstance()->tweetNotLoaded, this, &CTwitterScreen::tweetNotLoaded);
    ofNotifyEvent(twitterScreenDone,f,this);
}




