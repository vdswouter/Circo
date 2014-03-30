//
//  CBackGroundLayer.h
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#pragma once
#include "ofMain.h"
#include "CTriggerController.h"
#include "CPhoneDetector.h"
#include "CLoadTweet.h"
#include "CBGContainer.h"

class CBackGroundLayer {
    
    
    public:
    
    void timerTriggerDone(float &f);
    
    void setup();
    void update();
    void draw();
    
    void startWithBAndPicture();

    
private:

    
    CBGContainer        containerA;
    CBGContainer        containerB;
    
    ofImage           backgroundpicture;
    
    void            tweetLoaded(float &f);

    bool            bShowTwitter;

    int twitterStartTime;
    int twitterEndTime;
    bool bTwitterTimerReached;

};