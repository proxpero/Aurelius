//
//  Aurelius.h
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

#if TARGET_OS_MAC
    @import AppKit;
#elseif TARGET_OS_IOS
    @import UIKit;
#elseif TARGET_OS_TVOS
    @import UIKit;
#endif

//! Project version number for Aurelius
extern double Aurelius_VersionNumber;

//! Project version string for Aurelius
extern const unsigned char Aurelius_VersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Aurelius/PublicHeader.h>


