#import <objc/runtime.h>

#define kTweakName @"SwipeFolder"
#ifdef DEBUG
    #define NSLog(FORMAT, ...) NSLog(@"[%@: %s - %i] %@", kTweakName, __FILE__, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])
#else
    #define NSLog(FORMAT, ...) do {} while(0)
#endif

@interface SBFolderIconView : UIView
@property (nonatomic, retain) id folder;
@end
@interface SBIconController : NSObject
+(id)sharedInstance;
-(void)openFolder:(id)folder animated:(BOOL)animated;
@end

@interface SBFolderIconView (SwipeFolder)
-(void)swipeFolder_openFolder;
@end

%hook SBFolderIconView
-(id)initWithFrame:(CGRect)frame {
    if ((self = %orig)) {
        UISwipeGestureRecognizer* swipeRec = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFolder_openFolder)];
        swipeRec.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipeRec];
    }
    return self;
}
%new
-(void)swipeFolder_openFolder {
    [[%c(SBIconController) sharedInstance] openFolder:self.folder animated:YES];
}
%end
