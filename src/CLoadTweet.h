#pragma once
#include "ofMain.h"

#include "ofxJSONElement.h"
#include "CRandomGen.h"
#import "circoService.h"

class CLoadTweet{

private:
    static CLoadTweet* m_pSingleton;
    
    ofxJSONElement result;
    
protected: 
    CLoadTweet();
    
public:
    
    virtual ~CLoadTweet();
    static CLoadTweet* getInstance();
  
    void loadTweet();
    
    string message;
    string user;
    string picture;
    
    ofEvent<float> tweetLoaded;
    ofEvent<float> tweetNotLoaded;
    
};

