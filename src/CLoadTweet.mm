#include "CLoadTweet.h"

CLoadTweet* CLoadTweet::m_pSingleton = NULL;

CLoadTweet::CLoadTweet() {
    
}

CLoadTweet::~CLoadTweet() { }


CLoadTweet* CLoadTweet::getInstance() {
    if(m_pSingleton == NULL)
        m_pSingleton = new CLoadTweet;
    
    return m_pSingleton;
}

void CLoadTweet::loadTweet() {
    std::string url = "http://demo.littlemissrobot.com:2346/getTweets/";
	// Now parse the JSON
	bool parsingSuccessful = result.open(url);
    
    
	if (parsingSuccessful) {
        //don't know what i am doing here
        //took me 2 hours to get this parsed into a simple string
        int n = CRandomGen::random_in_range_int(0, result.size()-1);
        
        Json::Value& slot = result[n];
        
        //get content
        Json::Value jcontent;
        jcontent = slot.get("content", jcontent);
        message = ofSplitString(jcontent.asString(), "http")[0];
        //get username
        Json::Value juser;
        juser = slot.get("displayName", juser);
        user  = juser.asString();
        //get image
        Json::Value jimage;
        jimage = slot.get("image", jimage);
        picture  = jimage.asString();
        
        float f = 0;
        ofNotifyEvent(tweetLoaded,f,this);
        return;
        
	} else {
        float f = 0;
        ofNotifyEvent(tweetNotLoaded,f,this);
        return;
	}
}