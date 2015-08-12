#import "GoogleAnalyticsPlugin.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@implementation GoogleAnalyticsPlugin

- (void) setTrackingId: (CDVInvokedUrlCommand*)command
{
  CDVPluginResult* result = nil;
  NSString* trackingId = [command.arguments objectAtIndex:0];

  [GAI sharedInstance].trackUncaughtExceptions = YES;

  if (tracker) {
    [[GAI sharedInstance] removeTrackerByName:[tracker name]];
  }

  tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
  result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

  [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
}

- (void) setDispatchInterval: (CDVInvokedUrlCommand*)command
{
  CDVPluginResult* result = nil;
  NSTimeInterval dispatchInterval = [[command.arguments objectAtIndex:0] unsignedLongValue];

  [GAI sharedInstance].dispatchInterval = dispatchInterval;
  result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

  [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
}

- (void) setLogLevel: (CDVInvokedUrlCommand*)command
{
  CDVPluginResult* result = nil;

  GAILogLevel logLevel = (GAILogLevel)[command.arguments objectAtIndex:0];

  [[[GAI sharedInstance] logger] setLogLevel:logLevel];

  result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

  [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
}

- (void) get: (CDVInvokedUrlCommand*)command
{
  CDVPluginResult* result = nil;
  NSString* key = [command.arguments objectAtIndex:0];

  if (!tracker) {
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"tracker not initialized"];
  } else {
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[tracker get:key]];
  }

  [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
}

- (void) set: (CDVInvokedUrlCommand*)command
{
  CDVPluginResult* result = nil;
  NSString* key = [command.arguments objectAtIndex:0];
  NSString* value = [command.arguments objectAtIndex:1];

  if (!tracker) {
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"tracker not initialized"];
  } else {
    [tracker set:key value:value];
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  }

  [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
}

- (void) send: (CDVInvokedUrlCommand*)command
{
  CDVPluginResult* result = nil;
  NSDictionary* params = [command.arguments objectAtIndex:0];

  if (!tracker) {
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"tracker not initialized"];
  } else {
    [tracker send:params];
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  }

  [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
}

- (void) close: (CDVInvokedUrlCommand*)command
{
  CDVPluginResult* result = nil;

  if (!tracker) {
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"tracker not initialized"];
  } else {
    [[GAI sharedInstance] removeTrackerByName:[tracker name]];
    tracker = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  }

  [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
}

@end
