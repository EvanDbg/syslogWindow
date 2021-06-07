extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter();

#include "ELogWindow.h"
static ELogWindow *logWindow = nil;

void eLogMethodCallback(CFNotificationCenterRef center, 
                          void *observer, 
                          CFStringRef name, 
                          const void *object, 
                          CFDictionaryRef userInfo) {
  if( logWindow ){
    NSString *message = [((NSDictionary*)userInfo) objectForKey:@"message"];
    [logWindow addSyslogMessage:message];
  }
}

// %hook SBUIController
// -(void)finishLaunching{
%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
  %orig();
  logWindow = [[ELogWindow alloc] init];
}
%end

%ctor{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(),
                                    NULL,
                                    (CFNotificationCallback)eLogMethodCallback,
                                    CFSTR("fun.yfyf.elogMethodCallback"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorCoalesce);

    // dispatch_queue_t backgroundQueue = dispatch_queue_create("bgSyslogQueue", 0);
    // dispatch_async(backgroundQueue, ^{
    //     startTheSyslogThingy();
    // });

}