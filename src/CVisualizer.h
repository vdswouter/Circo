//
//  CVisualizer.h
//  Circo
//
//  Created by Wim Vanhenden on 23/03/14.
//
//

#pragma once

#include "ofMain.h"
#include "CRandomGen.h"
#import  "CSoundPlayer.h"

class CVisualizer {
private:
    static CVisualizer* m_pSingleton;
    
    int scene;
    
    float audio;
    float scale;
    float speed;
    
    bool switched;
    
    ofEasyCam            cam;
    ofSpherePrimitive    sphere;
    ofImage              texture;
    
    
    void drawScene0();
    void drawScene1();
    void drawScene2();
    void drawScene3();
    void drawScene4();
    
    int totalscenes;
    
protected:
    CVisualizer();
    
public:
    
    virtual ~CVisualizer();
    static CVisualizer* getInstance();
    
    void setup();
    void update();
    void draw();
    
    
    void setTexture(string _path);
   
    void setScene(int __scene);
    void setScale(float __scale);
    void setRotation(float __speed);
    
    void songChanged();
    
};