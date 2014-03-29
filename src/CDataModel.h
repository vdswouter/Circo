//
//  CPhoneSelector.h
//  CircoNonNative
//
//  Created by Wim Vanhenden on 10/03/14.
//
//

#pragma once

#include "ofMain.h"


enum SCREEN_MODE{
	INTRO_SCREEN = 1,
	VOICE_INTRO_SCREEN = 2,
    VISUALIZER_SCREEN = 3,
    NAVIGATION_SCREEN = 4,
    TWITTER_SCREEN = 5,
};


class CDataModel {
private:
    static CDataModel* m_pSingleton;
    
    vector<string> bandpicturespaths;
    
protected:
    CDataModel();
    
public:
    
    virtual ~CDataModel();
    static CDataModel* getInstance();
    
    void setup();
    string getRandomBandPicture();
    
    vector<string> songtitles;
    
    vector<string> songreferences;
    
    int     screenmode;
    
    float   screenfadestep;
};