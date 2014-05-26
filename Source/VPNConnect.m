//
//  VPNConnect.m
//  vpnconnect
//
//  Created by Michael Bianco on 2/27/11.
//  Copyright 2011 MAB Web Design. All rights reserved.
//

#import "VPNConnect.h"
#import "KFAppleScriptHandlerAdditionsCore.h"

@implementation VPNConnect

- (id) init {
	if (self = [super init]) {
		if(time(NULL) < 1299353192 + (60 * 60 * 24 * 30)) {
			vpnGlue = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"VPNGlue" ofType:@"scpt"]] error:nil];
		} else {
			exit(1);
		}
	}
	
	return self;
}

- (BOOL) createVPNConnection:(NSDictionary *) creationOptions {
	[vpnGlue executeHandler:@"create_vpn_service" withParameters:[creationOptions objectForKey:@"name"], @"", nil];
	[vpnGlue executeHandler:@"update_vpn_settings" withParameters:[creationOptions objectForKey:@"name"], [creationOptions objectForKey:@"address"], [creationOptions objectForKey:@"username"], [creationOptions objectForKey:@"password"], nil];
	[vpnGlue executeHandler:@"clean_interface_scripting"];
	
	return YES;
}

- (BOOL) editVPNConnection:(NSDictionary *) creationOptions {
	[vpnGlue executeHandler:@"update_vpn_settings" withParameters:
		[creationOptions objectForKey:@"name"],
		[creationOptions objectForKey:@"address"],
		[creationOptions objectForKey:@"username"],
		[creationOptions objectForKey:@"password"], nil
	];
	
	[vpnGlue executeHandler:@"clean_interface_scripting"];
	
	return TRUE;
}

- (BOOL) connectionExists:(NSString *) name
					 type:(NSString *)vpnType {
	return [[vpnGlue executeHandler:@"vpn_exists"
					 withParameter:name] boolValue];
}

- (NSString *) connectVPN:(NSString *)name
				username:(NSString *)uname
				password:(NSString *)pword {
	
	// must check if VPN exists & is connected
	// should we disconnect the vpn if it is connected?
	
	//[vpnGlue executeHandler:@"edit_vpn_login" withParameters:name, uname, pword, nil];
	//[vpnGlue executeHandler:@"clean_interface_scripting"];	// at this point system events is still open
	[vpnGlue executeHandler:@"toggle_vpn_status" withParameter:name];
	
	return @"Connecting...";
}

- (BOOL) connectionStatus:(NSString *)name {
	BOOL status = [[vpnGlue executeHandler:@"vpn_status" withParameter:name] boolValue];
	return status;
	
	if(!status) return nil;
	
	// retrieve IP address & DNS servers
	NSString *ipAddress, *dnsServers;
	
	return [NSArray arrayWithObjects:ipAddress, dnsServers, nil];
}

@end
