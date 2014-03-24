#import <Foundation/Foundation.h>

@interface CPersistantData : NSObject {
    bool  firstrun;
    int   currentsong;
    NSArray *votes;
    
    NSMutableArray  *tempvotes;
    
}

@property bool firstrun;
@property int currentsong;
@property (nonatomic,retain) NSArray *votes;
@property (nonatomic,retain) NSMutableArray *tempvotes;

+ (id)sharedManager;


-(void) saveData;
-(void) loadData;




@end