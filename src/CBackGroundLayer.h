//
//  CBackGroundLayer.h
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#pragma once
#include "ofMain.h"
#include "CPhotoLibPicture.h"
#include "CBAndPicture.h"
#include "CTwitterPicture.h"
#include "CTriggerController.h"
#include "CPhoneDetector.h"
#include "CRandomGen.h"
#include "CLoadTweet.h"

class CBackGroundLayer {
    
    
    public:
    
    void timerTriggerDone(float &f);
    
    void setup();
    void update();
    void draw();
    
    void startWithBAndPicture();

    
private:

    CBAndPicture        bandpicture;
    CPhotoLibPicture    libpicture;
    CTwitterPicture     twitterpicture;
    
    ofImage           backgroundpicture;
    
    ofFbo       *prev;
    ofFbo       *current;
    
    void fadeOutPrev();
    void fadeInCurrent();
    
    bool bdoTransitionIn;
    bool bdoTransitionOut;
    
    float fadeinval;
    float fadeoutval;
    
    ofShader fadeshaderin;
    ofShader fadeshaderout;
    
    void            tweetLoaded(float &f);

    bool            bShowTwitter;
    
    
    int twitterStartTime;
    int twitterEndTime;
    bool bTwitterTimerReached;

};