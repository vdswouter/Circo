//
//  CVisualizer.cpp
//  Circo
//
//  Created by Wim Vanhenden on 23/03/14.
//
//

#include "CVisualizer.h"



CVisualizer* CVisualizer::m_pSingleton = NULL;

CVisualizer::CVisualizer() {
}

CVisualizer::~CVisualizer() {
}

CVisualizer* CVisualizer::getInstance() {
    if(m_pSingleton == NULL)
        m_pSingleton = new CVisualizer;
    return m_pSingleton;
}

void CVisualizer::setup() {
    totalscenes = 4;
    cam.setDistance(120);
    //sphere.setUseVbo(true);
    setTexture("images/textures/texture.jpg");
    setScale(3);
    setRotation(0.3);
    setScene(3);
}

void CVisualizer::update() {
    [[CSoundPlayer sharedManager] update];
    audio = [[CSoundPlayer sharedManager] thescale];
    
    if (audio > 0.9 && ofGetFrameNum()%60 < 5) {
        int cscene =CRandomGen::random_in_range_int(0, totalscenes);
        setScene(cscene);
    }
}

void CVisualizer::draw() {
    
    float __spinX = sin(ofGetElapsedTimef()*.35f)*audio*speed;
    float __spinY = cos(ofGetElapsedTimef()*.075f)*audio*speed;
    
    
    sphere.rotate(__spinX, 1.0, 0.0, 0.0);
    sphere.rotate(__spinY, 0, 1.0, 0.0);
    sphere.pan((audio*3) * speed);
    
    //ofEnableAlphaBlending();
    //ofEnableBlendMode(OF_BLENDMODE_ADD);
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 254,200);
    cam.begin();
        ofEnableDepthTest();
            texture.bind();
    
            switch(scene) {
                case 0: drawScene0(); break;
                case 1: drawScene1(); break;
                case 2: drawScene2(); break;
                case 3: drawScene3(); break;
            }
    
            switched = false;
    
            texture.unbind();
        ofDisableDepthTest();
    cam.end();
    ofSetColor(255, 255, 255,255);
    ofDisableAlphaBlending();
}


void CVisualizer::setTexture(string _path) {
    texture.loadImage(_path);
}

//--------------------------------------------------------------
void CVisualizer::setScene(int __scene){
    
    scene = __scene;
    switched = true;
    
}

//--------------------------------------------------------------
void CVisualizer::setScale(float __scale){
    
    scale = __scale;
    
}

//--------------------------------------------------------------
void CVisualizer::setRotation(float __speed){
    
    speed = __speed;
    
}

//--------------------------------------------------------------
void CVisualizer::drawScene0() {
    
    float __scale =(audio)*scale;
    
    int __resolution = (audio*8)+3;
    
    sphere.setResolution(__resolution);
    sphere.setScale(__scale);
    sphere.pan((audio*3) * speed);

    sphere.draw();
    sphere.setScale(__scale+(audio*0.5));
    sphere.drawWireframe();

}

void CVisualizer::drawScene2() {
    float __scale =(audio)*scale;
    
    int __resolution = (1.2 - audio) * 35 + 8;
    
    if(switched) {
        sphere.setResolution(15);
    }
    
    if (audio > 0.9 && ofGetFrameNum()%90 < 20) {
        sphere.setResolution(__resolution);
    }
    
    
    sphere.setScale(__scale);

    vector<ofMeshFace> faces = sphere.getMesh().getUniqueFaces();
    if(faces.size() > 1) {
        
        for(int i=0; i<faces.size(); ++i) {
             int val = audio < 0.5 ? __resolution / 4 : 8;
            
            if(i%val < val / 2) continue;
            // Get face normal
            ofVec3f normal = faces[i].getFaceNormal();
            
            // Get random displacement
            // for the current face
            float random = audio * 0.4;
            
            // Displace vertices
            for(int j=0; j<3; j++) {
                faces[i].setVertex(j, faces[i].getVertex(j) + normal * random );
            }
        }
        // After displacing the vertices
        // push the result back to the mesh
        sphere.getMesh().setFromTriangles(faces);
    }
    
    sphere.draw();
    sphere.setScale(__scale+(audio*0.5));
    sphere.drawWireframe();
    
}

void CVisualizer::drawScene1(){
    int __resolution = (1 - audio) * 8;
    if(__resolution < 2) __resolution = 2;
    sphere.setResolution(__resolution);
   
    float __scale =(audio)*scale;
    sphere.setScale(__scale*scale);
    
    vector<ofMeshFace> faces = sphere.getMesh().getUniqueFaces();
    if(faces.size() > 1) {
        
        // Displace vertices based
        // on current scene & audio
        for(int i=0; i<faces.size(); ++i) {
            
            // Get face normal
            ofVec3f normal = faces[i].getFaceNormal();
            
            // Get random displacement
            // for the current face
            float random = audio * 15;
            
            // Displace vertices
            for(int j=0; j<3; j++) {
                faces[i].setVertex(j, faces[i].getVertex(j) + normal * random );
            }
            
        }
        sphere.getMesh().setFromTriangles(faces);
    }
    
    sphere.draw();
    sphere.setScale(__scale+(audio*3));
    sphere.drawWireframe();
}

void CVisualizer::drawScene3() {
    float __scale =(audio)*scale;
    sphere.setScale(__scale);
    sphere.draw();
}


void CVisualizer::songChanged(){
    string path= "images/textures/"+ofToString([[CSoundPlayer sharedManager] currentsong])+".jpg";
    setTexture(path);
    setScale(2);
    setScene(CRandomGen::random_in_range_int(0, totalscenes));
    //setScene(4);
}

