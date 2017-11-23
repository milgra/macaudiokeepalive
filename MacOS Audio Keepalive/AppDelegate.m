
    #import "AppDelegate.h"
    #import "WavePlayer.h"

    @interface AppDelegate ()
    {
        NSStatusItem* statusItem;
        WavePlayer* player;
    }
    @end

    @implementation AppDelegate

    - ( void ) applicationDidFinishLaunching : ( NSNotification*) theNotification
    {
        NSMenu *menu = [ [ NSMenu alloc ] init ];

        [ menu addItemWithTitle : @"Running" action : nil keyEquivalent : @"" ];
        [ menu addItem : [ NSMenuItem separatorItem ] ]; // A thin grey line
        [ menu addItemWithTitle : @"Donate if you like the app" action : @selector(support) keyEquivalent : @"" ];
        [ menu addItemWithTitle : @"Check for updates" action : @selector(update) keyEquivalent : @"" ];
        [ menu addItemWithTitle : @"Quit" action : @selector(terminate) keyEquivalent : @"" ];

        statusItem = [ [ NSStatusBar systemStatusBar ] statusItemWithLength : NSVariableStatusItemLength ];
        [ statusItem setToolTip : @"Audio Keepalive" ];
        [ statusItem setMenu : menu ];
        [ statusItem setImage : [ NSImage imageNamed : @"icon" ] ];
        [ [ statusItem image ] setTemplate : YES ];
        
        player = [[WavePlayer alloc] init ];
    }

    - ( void ) terminate
    {
        [ NSApp terminate : nil ];
    }

    - ( void ) support
    {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"https://paypal.me/milgra"]];
    }

    - ( void ) update
    {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"http://milgra.com/macos-audio-keepalive.html"]];
    }

    @end
