#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import "GAI.h"

@interface GoogleAnalyticsPlugin : CDVPlugin {
  id<GAITracker> tracker;
}

- (void) setTrackingId: (CDVInvokedUrlCommand*)command;
- (void) setDispatchInterval: (CDVInvokedUrlCommand*)command;
- (void) setIDFAEnabled: (CDVInvokedUrlCommand*)command;
- (void) setIDFADisabled: (CDVInvokedUrlCommand*)command;
- (void) setLogLevel: (CDVInvokedUrlCommand*)command;
- (void) get: (CDVInvokedUrlCommand*)command;
- (void) set: (CDVInvokedUrlCommand*)command;
- (void) send: (CDVInvokedUrlCommand*)command;
- (void) close: (CDVInvokedUrlCommand*)command;

@end
