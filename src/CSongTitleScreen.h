//
//  CSongTitleScreen.h
//  Circo
//
//  Created by Wim Vanhenden on 26/03/14.
//
//
#pragma once

#include "ofMain.h"

class CSongTitleScreen {
private:
    float               textxpos;
    static CSongTitleScreen* m_pSingleton;
    
    bool        bdraw;
    
protected:
    CSongTitleScreen();
    
public:
    
    virtual ~CSongTitleScreen();
    static CSongTitleScreen* getInstance();
    void update();
    void draw();
    
    void songChanged();
    
    int counter;
};