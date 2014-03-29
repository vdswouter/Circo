#pragma once
#include "ofMain.h"
#include "CPhoneDetector.h"

class CLMRView {
    
public:
    
    void setup();
    void update();
    void draw();
    
    void touchDown(ofTouchEventArgs & touch);
    void touchMoved(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void touchDoubleTap(ofTouchEventArgs & touch);
    void touchCancelled(ofTouchEventArgs & touch);
    
    ofEvent<float> removeView;
    ofEvent<float> viewReady;
    
private:
    
    ofImage image;
    
    float fadeval;
    
    float backgroundfadeval;
    
    bool fadein;
    bool fadeout;
    
    ofRectangle closecross;
    
    
    void setHitAreasIphone4NonRetina();
    void setHitAreasIphone5NonRetina();
    
    
    float       starttime;
    float       endtime;
    bool        bTimerReached;
    bool        bTimerIsRunning;
    
    void        startTimer(float time);
    void        stopTimer();
    
    float       timertime;
    
};