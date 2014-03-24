//
//  CTriggerController.h
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#pragma once
#include "ofMain.h"
#include "CTimer.h"

class CTriggerController {
private:
    static CTriggerController* m_pSingleton;
    
    CTimer ctimer;
    
    CTimer twittertimer;
    
protected:
    CTriggerController();
    
public:
    
    virtual ~CTriggerController();
    static CTriggerController* getInstance();
    
    void setup();
    void onUpdate(ofEventArgs &data);
    void onDraw(ofEventArgs &data);
    
    
    void twitterTimerDone(float &f);
    void timerDone(float &f);
    
    ofEvent<float> timmerTrigger;
    
    ofEvent<float> twitterTimerTrigger;
    
    
    
};