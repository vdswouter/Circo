//
//  CTimer.cpp
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#include "CTimer.h"


void CTimer::setup(int _randommin, int _randommax) {
    
    randommax = _randommax;
    randommin = _randommin;
    
    ofAddListener(ofEvents().update, this, &CTimer::onUpdate);
    ofAddListener(ofEvents().draw, this, &CTimer::onDraw);
    
    startTime = ofGetElapsedTimeMillis();
    endTime = ofRandom(randommin,randommax);
    
}

void CTimer::onUpdate(ofEventArgs &data) {
    if (bTimerReached) {
        bTimerReached = false;
        startTime = ofGetElapsedTimeMillis();
        endTime = (int)ofRandom(randommin, randommax);
        float f = 0;
        ofNotifyEvent(timerDone,f,this);
    }
}

void CTimer::onDraw(ofEventArgs &data) {
    int timer = ofGetElapsedTimeMillis() - startTime;
    
    if(timer >= endTime && !bTimerReached) {
        bTimerReached = true;
    }
}