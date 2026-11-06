// Jellyfin for iOS 6 - a thin native shell around the bundled web app (Resources/index.html).
// Written without ARC so it builds cleanly for a 6.0 deployment target.
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RootViewController : UIViewController <UIWebViewDelegate> {
    UIWebView *web;
}
@end

@implementation RootViewController

- (void)loadView {
    UIView *v = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    v.backgroundColor = [UIColor colorWithRed:0.04 green:0.04 blue:0.06 alpha:1.0];
    self.view = v;
    [v release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *bg = [UIColor colorWithRed:0.04 green:0.04 blue:0.06 alpha:1.0];
    web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    web.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    web.backgroundColor = bg;
    web.opaque = NO;
    web.delegate = self;
    web.scalesPageToFit = NO;
    web.dataDetectorTypes = UIDataDetectorTypeNone;
    web.mediaPlaybackRequiresUserAction = NO;   // lets video/music start and auto-advance from the page
    web.allowsInlineMediaPlayback = NO;         // video opens in the full-screen iOS player
    [[web scrollView] setBounces:NO];
    [self.view addSubview:web];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    if (path) {
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

// iOS 6 rotation
- (BOOL)shouldAutorotate { return YES; }
- (NSUInteger)supportedInterfaceOrientations { return UIInterfaceOrientationMaskAllButUpsideDown; }
// iOS 5 rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)o { return o != UIInterfaceOrientationPortraitUpsideDown; }

- (void)dealloc {
    web.delegate = nil;
    [web release];
    [super dealloc];
}
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *window;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // keep music playing when the screen locks or you leave the app
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];

    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor colorWithRed:0.04 green:0.04 blue:0.06 alpha:1.0];
    RootViewController *vc = [[RootViewController alloc] init];
    window.rootViewController = vc;
    [vc release];
    [window makeKeyAndVisible];
    return YES;
}

- (void)dealloc {
    [window release];
    [super dealloc];
}
@end
