#include "ofMain.h"
#include "testApp.h"

int main(){
	//ofSetupOpenGL(1024,768,OF_FULLSCREEN);			// <-------- setup the GL context
//	ofRunApp(new testApp());
    
    ofAppiOSWindow * window = new ofAppiOSWindow();
    //window->enableHardwareOrientation();
    //window->enableOrientationAnimation();
    //window->enableRetina();
    window->enableRendererES2();
    window->enableDepthBuffer();
    //window->disableHardwareOrientation();
    //window->disableOrientationAnimation();
    ofSetupOpenGL(window, 1024,768, OF_FULLSCREEN);
    ofRunApp(new testApp());
    
}
