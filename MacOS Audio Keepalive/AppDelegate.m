
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
        [ menu addItemWithTitle : @"Quit" action : @selector(terminate:) keyEquivalent : @"" ];

        statusItem = [ [ NSStatusBar systemStatusBar ] statusItemWithLength : NSVariableStatusItemLength ];
        [ statusItem setToolTip : @"Optical Audio Port Keepalive" ];
        [ statusItem setMenu : menu ];
        [ statusItem setImage : [ NSImage imageNamed : @"mak.png" ] ];
        [ [ statusItem image ] setTemplate : YES ];
        
        player = [[WavePlayer alloc] init ];
    }

    - ( void ) terminate
    {
        [ NSApp terminate : nil ];
    }

    @end
