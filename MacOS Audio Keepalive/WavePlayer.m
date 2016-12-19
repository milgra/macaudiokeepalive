
    #import "WavePlayer.h"


	// plain c callback function called by AudioQueue when last buffer is empty

	void updateQueue (  void*               theData   , 
                        AudioQueueRef       theQueue  , 
                        AudioQueueBufferRef theBuffer )
	{
    
		AudioQueueEnqueueBuffer( theQueue ,
                                 theBuffer , 
                                 0 , 
                                 NULL );		
		
	}
    
	
    @implementation WavePlayer


    // constructor

	- ( id ) init
	{
    
        self = [ super init ];
        
        if ( self )
        {
        
            // setup audio format
                    
            audioFormat = ( AudioStreamBasicDescription )
            {
                .mFormatID          = kAudioFormatLinearPCM,
                .mFormatFlags       = 0 | 
                                      kAudioFormatFlagIsPacked | 
                                      kAudioFormatFlagIsSignedInteger | 
                                      kAudioFormatFlagsNativeEndian ,
                .mSampleRate        = 44100 ,
                .mBitsPerChannel    = 8,
                .mChannelsPerFrame  = 1,
                .mBytesPerFrame     = 1,
                .mFramesPerPacket   = 1,
                .mBytesPerPacket    = 1,
            };
            
            // create output and assign to audioQueue
                                            
            AudioQueueNewOutput(
                &audioFormat ,			// audio format
                updateQueue  ,			// callback function on buffer update request
                NULL         ,			// custom parameter, passing ourself
                NULL         ,			// timing comes from the audioqueue's thread
                NULL         ,			// deafult loop mode 
                0            ,			// flags
                &audioQueue  );         // audio queue which stores the created session
            
            // allocate and fill up buffers

            for ( int bufferCount = 0 ; 
                      bufferCount < 2 ; 
                    ++bufferCount   )
            {
            
                // allocate buffer
            
                AudioQueueAllocateBuffer(	
                    audioQueue                   , 
                    kBufferSize                  ,
                    &frameBuffers[ bufferCount ] );
                
                // fill up buffer with zeroes and ones
                
                for ( int index = 0 ; 
                          index < kBufferSize / 4 ;
                          index++ )
                {
                
                    int* buffer;
                    
                    buffer          = ( int* ) ( frameBuffers[ bufferCount ]->mAudioData );
                    buffer[ index ] = ( index % 200 ) == 0 ? 1 : 0;
                
                }
                
                // set size
                        
                frameBuffers[ bufferCount ]->mAudioDataByteSize = kBufferSize;
                
                // enqueue buffer

                AudioQueueEnqueueBuffer( audioQueue                  ,
                                         frameBuffers[ bufferCount ] , 
                                         0                           , 
                                         NULL                       );
                             
            }
            
            // set volume

            AudioQueueSetParameter( 
                audioQueue              , 
                kAudioQueueParam_Volume , 
                0.01                    );
            
            // start playing audioqueue

            AudioQueueStart( 
                audioQueue , 
                NULL       );            
        
        }
        
        return self;
	
	}
	
	
	// destructor
	
	- ( void ) dealloc
	{
	
		AudioQueueDispose( audioQueue , true );
		
		//[ super dealloc ];
	
	}
    
    
    @end
