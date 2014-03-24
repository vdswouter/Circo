//
//  CNavigationView.h
//  Circo
//
//  Created by Wim Vanhenden on 19/03/14.
//
//

#pragma once
#include "ofMain.h"
#include "CPhoneDetector.h"
#include "CQueView.h"
#include "CTrackView.h"
#include "CVoteView.h"

class CNavigationView {
    
public:
    
    void setup();
    void update();
    void draw();
    
    void touchDown(ofTouchEventArgs & touch);
    void touchMoved(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void touchDoubleTap(ofTouchEventArgs & touch);
    void touchCancelled(ofTouchEventArgs & touch);
    
    ofEvent<float> removeNavigationView;
    

private:
    
    ofImage image;
    
    float fadeval;
    
    float backgroundfadeval;
    
    bool fadein;
    bool fadeout;
    
    ofRectangle touchrectanglevote;
    ofRectangle touchrectangleque;
    ofRectangle touchrectangletracks;
    
    void setHitAreasIphone4NonRetina();
    void setHitAreasIphone5NonRetina();
    
    CQueView *queview;
    CTrackView *trackview;
    CVoteView *voteview;
    
    bool       bscreenisselected;
    
    void       removeView(float &f);
    
    float       starttime;
    float       endtime;
    bool        bTimerReached;
    bool        bTimerIsRunning;
    
    void        startTimer(float time);
    void        stopTimer();
    
};