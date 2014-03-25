//
//  CTimer.h
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#pragma once

#include "ofMain.h"

class CTimer {
public:
    
    void setup(int _randommin, int _randommax);
    
    ofEvent<float> timerDone;
    
    void startTimer();
    void stopTimer();
    
private:
    
    int startTime;
    int endTime;
    
    bool bTimerReached;
    bool bTimerIsRunning;
    
    void onUpdate(ofEventArgs &data);
    void onDraw(ofEventArgs &data);
    
    int randommax;
    int randommin;
    
    
    
};