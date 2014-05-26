//
//  VPNConnect.h
//  vpnconnect
//
//  Created by Michael Bianco on 2/27/11.
//  Copyright 2011 MAB Web Design. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VPNConnect : NSObject {
	NSAppleScript *vpnGlue;
}

- (BOOL) connectionExists:(NSString *) name type:(NSString *)vpnType;
- (BOOL) createVPNConnection:(NSDictionary *) creationOptions;
- (BOOL) editVPNConnection:(NSDictionary *) creationOptions;
- (NSString *) connectVPN:(NSString *)name username:(NSString *)uname password:(NSString *)pword;
- (BOOL) connectionStatus:(NSString *)name;

@end
