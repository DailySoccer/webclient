#import <Cordova/CDV.h>
#import "ComScorePlugin.h"
#import "ComScore/ComScore.h"

@implementation ComScorePlugin

bool foregroundOnly = YES;
NSString *applicationName;

- (void) pluginInitialize
{
    //[SCORAnalytics setAppContext];
}

- (void)setAppContext:(CDVInvokedUrlCommand*)command
{
    //[SCORAnalytics setAppContext];
}

- (void)setCustomerData:(CDVInvokedUrlCommand*)command
{
    
    NSString *customerId = [command.arguments objectAtIndex:0];
    NSString *customerKey = [command.arguments objectAtIndex:1];

    SCORPublisherConfiguration *myPublisherConfig = [SCORPublisherConfiguration publisherConfigurationWithBuilderBlock:^(SCORPublisherConfigurationBuilder * builder) {
        builder.publisherId = customerId;
        builder.publisherSecret= customerKey;
        builder.usagePropertiesAutoUpdateMode = foregroundOnly == YES? SCORUsagePropertiesAutoUpdateModeForegroundOnly : SCORUsagePropertiesAutoUpdateModeForegroundAndBackground;
        builder.applicationName = applicationName;
    }];
    
    [[SCORAnalytics configuration] addClientWithConfiguration:myPublisherConfig];
    [SCORAnalytics start];
    //[SCORAnalytics setCustomerC2: customerId];
    //[SCORAnalytics setPublisherSecret: customerKey];
}

- (void) setAppName:(CDVInvokedUrlCommand*)command
{
    applicationName = [command.arguments objectAtIndex:0];
    
    //[SCORAnalytics setAppName: appName];
}


- (void) onEnterForeground:(CDVInvokedUrlCommand*)command
{
    [SCORAnalytics notifyEnterForeground];
}

- (void) onExitForeground:(CDVInvokedUrlCommand*)command
{
    [SCORAnalytics notifyExitForeground];
}

- (void) autoUpdateForeground:(CDVInvokedUrlCommand*)command
{
    //NSString *strIntervel = [command.arguments objectAtIndex:0];
    foregroundOnly = YES;
    //[SCORAnalytics enableAutoUpdate:interval foregroundOnly:YES];
}

- (void) autoUpdateBackground:(CDVInvokedUrlCommand*)command
{
    //NSString *strIntervel = [command.arguments objectAtIndex:0];
    foregroundOnly = NO;
    //[SCORAnalytics enableAutoUpdate:interval foregroundOnly:NO];
}

@end
