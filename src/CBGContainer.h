//
//  CBGContainer.h
//  Circo
//
//  Created by Wim Vanhenden on 30/03/14.
//
//

#pragma once

#include "ofMain.h"
#include "CBAndPicture.h"
#include "CPhotoLibPicture.h"
#include "CTwitterPicture.h"

class CBGContainer {
    
private:
    
    void fadeIn();
    void fadeOut();
    ofShader fadeshader;
    
    bool bDoTransitionIn;
    bool bDoTransitionOut;
    
    bool bDisplace;
    
    float fadeval;
    float enlargerval;
    
    
    CBAndPicture        bandpicture;
    CPhotoLibPicture    libpicture;
    CTwitterPicture     twitterpicture;
    
public:
    
    ofFbo  *image;
    
    void setup();
    
    void update();
    void draw();
    
    
    void startFadeIn();
    void startFadeOut();
    
    bool bisActive;
    
    void insertTweetPicture(string _path);
    
};