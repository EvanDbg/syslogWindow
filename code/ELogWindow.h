#import <libactivator/libactivator.h>
@interface ELogWindow: UIWindow <LAListener>
{
  NSMutableArray* savedMessages;
  UITextView *textView;
}
-(void)addSyslogMessage:(NSString*)message;
+(void)log:(NSString*)message;
@end