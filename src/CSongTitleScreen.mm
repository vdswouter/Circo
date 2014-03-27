//
//  CSongTitleScreen.cpp
//  Circo
//
//  Created by Wim Vanhenden on 26/03/14.
//
//

#include "CSongTitleScreen.h"

#include "NCFontController.h"
#include "CDataModel.h"

#import "CSoundPlayer.h"


CSongTitleScreen* CSongTitleScreen::m_pSingleton = NULL;

CSongTitleScreen::CSongTitleScreen() {
}

CSongTitleScreen::~CSongTitleScreen() {
}

CSongTitleScreen* CSongTitleScreen::getInstance() {
    if(m_pSingleton == NULL)
        m_pSingleton = new CSongTitleScreen;
    return m_pSingleton;
}

void CSongTitleScreen::draw() {
    
    if (counter<4) {
        string song = CDataModel::getInstance()->songtitles[[[CSoundPlayer sharedManager] currentsong]];
        
        ofRectangle rect = NCFontController::getInstance()->nanum30.getStringBoundingBox("you are listening to "+song+" by ..Circo",0, 0);
        
        textxpos+=4;
        if (textxpos>ofGetWidth()+rect.width) {
            textxpos = 0;
            counter++;
        }
        ofEnableAlphaBlending();
        ofEnableBlendMode(OF_BLENDMODE_ADD);
        
        NCFontController::getInstance()->nanum30.drawString("you are listening to "+song+" by ..Circo", textxpos-rect.width, ofGetHeight()-rect.height+20);
        ofDisableBlendMode();
        ofDisableAlphaBlending();
    }
    
}


void CSongTitleScreen::songChanged() {
    counter  =0;
}
