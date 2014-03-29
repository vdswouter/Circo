#import "CPersistantData.h"

NSString * const kCurrentSong = @"kLevel";
NSString * const kFirstRun = @"kScore";
NSString * const kVote = @"kVote";

static CPersistantData *sharedMyManager = nil;

@implementation CPersistantData

@synthesize firstrun;
@synthesize currentsong;
@synthesize votes;
@synthesize tempvotes;

#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}
+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedManager] retain];
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (id)retain {
    return self;
}
- (unsigned)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}
- (oneway void)release {
    // never release
}
- (id)autorelease {
    return self;
}
- (id)init {
    if (self = [super init]) {
        [self loadData];
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [super dealloc];
}

-(void)saveData
{
    [[NSUserDefaults standardUserDefaults]
     setBool:self.firstrun forKey:kFirstRun];
    
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSNumber numberWithInt:self.currentsong] forKey:kCurrentSong];
    
    self.votes = nil;

    self.votes = [[NSArray alloc] initWithArray:tempvotes];
    [[NSUserDefaults standardUserDefaults] setObject:self.votes forKey:kVote];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [votes release];
}

-(void)loadData {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kCurrentSong]) {
        
        self.firstrun = [[NSUserDefaults standardUserDefaults] objectForKey:kFirstRun];
        self.currentsong = [(NSNumber *)[[NSUserDefaults standardUserDefaults]
                                         objectForKey:kCurrentSong] intValue];
        
        self.votes = [[NSUserDefaults standardUserDefaults] objectForKey:kVote];
        self.tempvotes = [[NSMutableArray alloc] initWithArray:self.votes];
    
        
    }  else {
        
        self.firstrun = false;
        self.currentsong = 0;
        tempvotes = [[NSMutableArray alloc] init];
    }
}

@end