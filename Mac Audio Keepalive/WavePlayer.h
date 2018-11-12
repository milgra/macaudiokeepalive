
    #import <Cocoa/Cocoa.h>
    #import <AudioToolbox/AudioToolbox.h>


    #define kBufferSize 44100


	@interface WavePlayer : NSObject 
	{
		
		AudioQueueRef				audioQueue;
		AudioQueueBufferRef			frameBuffers[ 2 ];
		AudioStreamBasicDescription	audioFormat;

	}
	

    @end
