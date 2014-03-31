//
//  CVoteService.h
//  Circo
//
//  Created by Wim Vanhenden on 30/03/14.
//
//

#pragma once

#include "ofMain.h"
#include "ofxJSONElement.h"
#include "CRandomGen.h"
#import "circoService.h"

class CVoteService{
    
private:
    static CVoteService* m_pSingleton;
    
    ofxJSONElement result;
    
protected:
    CVoteService();
    
public:
    
    virtual ~CVoteService();
    static CVoteService* getInstance();
    
    bool doVote(int songnumber);
};

