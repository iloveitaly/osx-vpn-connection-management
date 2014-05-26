#!/bin/python

# VPNConnect.bundle test suite
# Michael Bianco, <http://mabblog.com/>

from Cocoa import *
import time

b = NSBundle.bundleWithPath_("vpnconnect.bundle")
vpn = b.principalClass().new()
testVPNName = 'Test VPN'

connectionExists = vpn.connectionExists_type_(testVPNName, "PPTP")

if not connectionExists:
	vpn.createVPNConnection_({
		'name':testVPNName,
		'type':'PPTP',	# or L2TP
		'address':'12.17.0.1',
		'username':'Mike',
		'password':'Bianco'
	})
else:
	vpn.editVPNConnection_({
		'name':testVPNName,
		'address':'12.172.0.1',
		'username':'MikeB',
		'password':'ianco'
	})
	
print "Connecting to VPN: " + str(vpn.connectVPN_username_password_(testVPNName, "Mike", "Bianco"))

checkLimit = 5
while checkLimit:
	print "Status: " + str(vpn.connectionStatus_(testVPNName))
	checkLimit -= 1
	time.sleep(1)