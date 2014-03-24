//
//  CTwitterScreen.h
//  Circo
//
//  Created by Wim Vanhenden on 20/03/14.
//
//

#pragma once
#include "ofMain.h"
#include "NCFontController.h"
#include "CLoadTweet.h"
#include "ofxJSONElement.h"
#import "circoService.h"


class CTwitterScreen {
    
public:
    
    void setup();
    void update(ofFbo &incomingfbo);
    void draw();
    
    ofEvent<float> twitterScreenDone;
    void tweetLoaded(float &f);
    void tweetNotLoaded(float &f);
    
private:
    
    ofImage bones;

    //glitch
    float val3;
    ofFbo               slitrender;
    ofShader            slitscanshader;
    
    ofFbo               convergencefbo;
    ofShader            convergenceshader;
    
    float               tweetxpos;
    
    int startTime;
    int endTime;
    
    bool bTimerReached;
    
    void drawBonesAndTweet();
    
};