#pragma once
#include "ofMain.h"

class NCFontController{

private:
    static NCFontController* m_pSingleton;
    
protected: 
    NCFontController();
    
public:
    
    virtual ~NCFontController();
    static NCFontController* getInstance();
    
    ofTrueTypeFont nanum30;
    
    ofTrueTypeFont nanum24;
    
    
    void setup();

};

