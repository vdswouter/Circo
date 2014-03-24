#include "NCFontController.h"

NCFontController* NCFontController::m_pSingleton = NULL;

NCFontController::NCFontController() {
    
}

NCFontController::~NCFontController() { }


NCFontController* NCFontController::getInstance()
{
    if(m_pSingleton == NULL)
        m_pSingleton = new NCFontController;
    
    return m_pSingleton;
}

void NCFontController::setup() {
    
    nanum30.loadFont("fonts/NanumScript.ttc", 30);
    
}