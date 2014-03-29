//
//  CTriggerController.cpp
//  Circo
//
//  Created by Wim Vanhenden on 14/03/14.
//
//

#include "CTriggerController.h"

CTriggerController* CTriggerController::m_pSingleton = NULL;

CTriggerController::CTriggerController() {
}

CTriggerController::~CTriggerController() {
}

CTriggerController* CTriggerController::getInstance() {
    if(m_pSingleton == NULL)
        m_pSingleton = new CTriggerController;
    return m_pSingleton;
}


void CTriggerController::setup() {
    twittertimer.setup(30000, 80000);
    ctimer.setup(10000,15000);
    ofAddListener(ctimer.timerDone ,this,&CTriggerController::timerDone);
    ofAddListener(twittertimer.timerDone, this, &CTriggerController::twitterTimerDone);
}


void CTriggerController::timerDone(float &f) {
    ofNotifyEvent(timmerTrigger,f,this);
}

void CTriggerController::twitterTimerDone(float &f) {
    ofNotifyEvent(twitterTimerTrigger,f,this);
}

void CTriggerController::startTimers(){
    twittertimer.startTimer();
    ctimer.startTimer();
}


void CTriggerController::stopTimers() {
    twittertimer.stopTimer();
    ctimer.stopTimer();
}
