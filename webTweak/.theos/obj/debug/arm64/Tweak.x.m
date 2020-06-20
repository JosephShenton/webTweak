#line 1 "Tweak.x"
#import "Headers/LSApplicationWorkspace.h"
#import "Headers/_LSAppLinkPlugIn.h"
#import "Extra/NSString+webTweak.h"
#include <spawn.h>
extern char **environ;
#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))

void respring() {
  pid_t pid;
  char *argv[] = {
    "killall",
    "-9",
    "SpringBoard",
    NULL
  };

  posix_spawn(&pid, argv[0], NULL, NULL, argv, environ);
  waitpid(pid, NULL, 0);
}

void installTweak( char *url ) {
  NSInteger intName = RAND_FROM_TO(1000000000, 1548720128);
  NSString *fileName = [@"" stringByAppendingFormat:@"%ld.deb ", (long)intName];
  NSString *filePath = @"/var/mobile/Downloads/";
  filePath = [filePath stringByAppendingString:fileName];

  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithUTF8String:url]]];
  [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    if (error) {
        NSLog(@"Download Error:%@",error.description);
    }
    if (data) {
        [data writeToFile:filePath atomically:YES];
        NSLog(@"File is saved to %@",filePath);
    }
  }];

  
  const char *filePathChar = [filePath UTF8String];
  pid_t pid;
  char *argv[] = {
    "dpkg",
    "-i",
    (char *)filePathChar,
    NULL
  };

  posix_spawn(&pid, argv[0], NULL, NULL, argv, environ);
  waitpid(pid, NULL, 0);

  UIViewController * controller = [UIApplication sharedApplication].keyWindow.rootViewController;
  while (controller.presentedViewController) {
      controller = controller.presentedViewController;
  }

  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"WebTweak" message:@"Are you ready to respring?" preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction* onAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

  }];

  UIAlertAction* offAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    respring();
  }];

  [alert addAction:offAction];
  [alert addAction:onAction];
  [controller presentViewController:alert animated:YES completion:nil];
}


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class UIApplication; @class LSApplicationWorkspace; 
static id (*_logos_orig$_ungrouped$LSApplicationWorkspace$URLOverrideForNewsURL$)(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$LSApplicationWorkspace$URLOverrideForNewsURL$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$LSApplicationWorkspace$URLOverrideForURL$)(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, NSURL*); static id _logos_method$_ungrouped$LSApplicationWorkspace$URLOverrideForURL$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, NSURL*); static id (*_logos_orig$_ungrouped$LSApplicationWorkspace$applicationsAvailableForOpeningURL$)(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id); static id _logos_method$_ungrouped$LSApplicationWorkspace$applicationsAvailableForOpeningURL$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id); static bool (*_logos_orig$_ungrouped$LSApplicationWorkspace$openURL$)(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id); static bool _logos_method$_ungrouped$LSApplicationWorkspace$openURL$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id); static bool (*_logos_orig$_ungrouped$LSApplicationWorkspace$openURL$withOptions$)(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id, id); static bool _logos_method$_ungrouped$LSApplicationWorkspace$openURL$withOptions$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id, id); static bool (*_logos_orig$_ungrouped$LSApplicationWorkspace$openURL$withOptions$error$)(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id, id, id*); static bool _logos_method$_ungrouped$LSApplicationWorkspace$openURL$withOptions$error$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id, id, id*); static void (*_logos_orig$_ungrouped$LSApplicationWorkspace$_sf_openURL$inApplication$withOptions$completionHandler$)(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id, id, id, id); static void _logos_method$_ungrouped$LSApplicationWorkspace$_sf_openURL$inApplication$withOptions$completionHandler$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id, id, id, id); static void (*_logos_orig$_ungrouped$LSApplicationWorkspace$_sf_openURL$withOptions$completionHandler$)(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id, id, id); static void _logos_method$_ungrouped$LSApplicationWorkspace$_sf_openURL$withOptions$completionHandler$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST, SEL, id, id, id); static BOOL (*_logos_orig$_ungrouped$UIApplication$openURL$)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, id); static BOOL _logos_method$_ungrouped$UIApplication$openURL$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, id); 

#line 71 "Tweak.x"

  
  static id _logos_method$_ungrouped$LSApplicationWorkspace$URLOverrideForNewsURL$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    NSLog(@"[WebTweak] URLOverrideForNewsURL");

    return _logos_orig$_ungrouped$LSApplicationWorkspace$URLOverrideForNewsURL$(self, _cmd, arg1);
  }

  static id _logos_method$_ungrouped$LSApplicationWorkspace$URLOverrideForURL$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURL* url) {
    NSLog(@"[WebTweak] URLOverrideForURL %@", url);

    if ([url.scheme isEqualToString:@"webtweak"]) {
      NSLog(@"[WebTweak] WebTweak link, installing..");

      if ([url.path isEqualToString:@"/"] || [url.path isEqualToString:@""]) {
        
        return [NSURL URLWithString:@"https://ignition.fun"];
      }

      NSRange range = [url.absoluteString rangeOfString:@"webtweak://"];
      if (range.location != NSNotFound) {
          NSLog(@"[WebTweak] Found \"webtweak://\" at %ld", (long)range.location);
          NSString *debURL = [url.absoluteString substringWithRange:NSMakeRange(range.location+11, [[url.absoluteString stringByReplacingOccurrencesOfString:@"webtweak://" withString:@""] length])];
          NSLog(@"[WebTweak] DEB URL: %@", debURL);

          const char *debChar = [debURL UTF8String];
          
          installTweak((char *)debChar);
      }

      return @"https://ignition.fun";
    }

    return _logos_orig$_ungrouped$LSApplicationWorkspace$URLOverrideForURL$(self, _cmd, url);
  }

  static id _logos_method$_ungrouped$LSApplicationWorkspace$applicationsAvailableForOpeningURL$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    NSLog(@"[WebTweak] applicationsAvailableForOpeningURL");
    return _logos_orig$_ungrouped$LSApplicationWorkspace$applicationsAvailableForOpeningURL$(self, _cmd, [self URLOverrideForURL:arg1]);
  }

  static bool _logos_method$_ungrouped$LSApplicationWorkspace$openURL$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    NSLog(@"[WebTweak] openURL");
    return _logos_orig$_ungrouped$LSApplicationWorkspace$openURL$(self, _cmd, [self URLOverrideForURL:arg1]);
  }

  static bool _logos_method$_ungrouped$LSApplicationWorkspace$openURL$withOptions$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    NSLog(@"[WebTweak] openURL:withOptions");
    return _logos_orig$_ungrouped$LSApplicationWorkspace$openURL$withOptions$(self, _cmd, [self URLOverrideForURL:arg1], arg2);
  }

  static bool _logos_method$_ungrouped$LSApplicationWorkspace$openURL$withOptions$error$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id* arg3) {
    NSLog(@"[WebTweak] openURL:withOptions:error");
    return _logos_orig$_ungrouped$LSApplicationWorkspace$openURL$withOptions$error$(self, _cmd, [self URLOverrideForURL:arg1], arg2, arg3);
  }

  

  static void _logos_method$_ungrouped$LSApplicationWorkspace$_sf_openURL$inApplication$withOptions$completionHandler$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3, id arg4) {
    NSLog(@"[WebTweak] _sf_openURL:inApplication");
    _logos_orig$_ungrouped$LSApplicationWorkspace$_sf_openURL$inApplication$withOptions$completionHandler$(self, _cmd, [self URLOverrideForURL:arg1], arg2, arg3, arg4);
  }

  static void _logos_method$_ungrouped$LSApplicationWorkspace$_sf_openURL$withOptions$completionHandler$(_LOGOS_SELF_TYPE_NORMAL LSApplicationWorkspace* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3) {
    NSLog(@"[WebTweak] _sf_openURL:withOptions");
    _logos_orig$_ungrouped$LSApplicationWorkspace$_sf_openURL$withOptions$completionHandler$(self, _cmd, [self URLOverrideForURL:arg1], arg2, arg3);
  }




  
static BOOL _logos_method$_ungrouped$UIApplication$openURL$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
  if ([arg1 isKindOfClass:[NSString class]] || [arg1 isKindOfClass:[NSURL class]]) { 
    if ([arg1 isKindOfClass:[NSString class]]) { 
      NSString *url = arg1;
      if([url hasPrefix:@"webtweak://"]) { 
        url = [url stringByReplacingOccurrencesOfString:@"webtweak://" withString:@""];

        
        const char *debChar = [url UTF8String];
          
        installTweak((char *)debChar);

        return YES;
      } else {
        return _logos_orig$_ungrouped$UIApplication$openURL$(self, _cmd, arg1);
      }

    } else if ([arg1 isKindOfClass:[NSURL class]]) { 

      NSString *url = (NSString*)arg1;

      if([url hasPrefix:@"webtweak://"]) { 
        url = [url stringByReplacingOccurrencesOfString:@"webtweak://" withString:@""];

        
        const char *debChar = [url UTF8String];
          
        installTweak((char *)debChar);
        
        return YES;
      } else {
        return _logos_orig$_ungrouped$UIApplication$openURL$(self, _cmd, arg1);
      }
    }
  }
  return NO;
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$LSApplicationWorkspace = objc_getClass("LSApplicationWorkspace"); MSHookMessageEx(_logos_class$_ungrouped$LSApplicationWorkspace, @selector(URLOverrideForNewsURL:), (IMP)&_logos_method$_ungrouped$LSApplicationWorkspace$URLOverrideForNewsURL$, (IMP*)&_logos_orig$_ungrouped$LSApplicationWorkspace$URLOverrideForNewsURL$);MSHookMessageEx(_logos_class$_ungrouped$LSApplicationWorkspace, @selector(URLOverrideForURL:), (IMP)&_logos_method$_ungrouped$LSApplicationWorkspace$URLOverrideForURL$, (IMP*)&_logos_orig$_ungrouped$LSApplicationWorkspace$URLOverrideForURL$);MSHookMessageEx(_logos_class$_ungrouped$LSApplicationWorkspace, @selector(applicationsAvailableForOpeningURL:), (IMP)&_logos_method$_ungrouped$LSApplicationWorkspace$applicationsAvailableForOpeningURL$, (IMP*)&_logos_orig$_ungrouped$LSApplicationWorkspace$applicationsAvailableForOpeningURL$);MSHookMessageEx(_logos_class$_ungrouped$LSApplicationWorkspace, @selector(openURL:), (IMP)&_logos_method$_ungrouped$LSApplicationWorkspace$openURL$, (IMP*)&_logos_orig$_ungrouped$LSApplicationWorkspace$openURL$);MSHookMessageEx(_logos_class$_ungrouped$LSApplicationWorkspace, @selector(openURL:withOptions:), (IMP)&_logos_method$_ungrouped$LSApplicationWorkspace$openURL$withOptions$, (IMP*)&_logos_orig$_ungrouped$LSApplicationWorkspace$openURL$withOptions$);MSHookMessageEx(_logos_class$_ungrouped$LSApplicationWorkspace, @selector(openURL:withOptions:error:), (IMP)&_logos_method$_ungrouped$LSApplicationWorkspace$openURL$withOptions$error$, (IMP*)&_logos_orig$_ungrouped$LSApplicationWorkspace$openURL$withOptions$error$);MSHookMessageEx(_logos_class$_ungrouped$LSApplicationWorkspace, @selector(_sf_openURL:inApplication:withOptions:completionHandler:), (IMP)&_logos_method$_ungrouped$LSApplicationWorkspace$_sf_openURL$inApplication$withOptions$completionHandler$, (IMP*)&_logos_orig$_ungrouped$LSApplicationWorkspace$_sf_openURL$inApplication$withOptions$completionHandler$);MSHookMessageEx(_logos_class$_ungrouped$LSApplicationWorkspace, @selector(_sf_openURL:withOptions:completionHandler:), (IMP)&_logos_method$_ungrouped$LSApplicationWorkspace$_sf_openURL$withOptions$completionHandler$, (IMP*)&_logos_orig$_ungrouped$LSApplicationWorkspace$_sf_openURL$withOptions$completionHandler$);Class _logos_class$_ungrouped$UIApplication = objc_getClass("UIApplication"); MSHookMessageEx(_logos_class$_ungrouped$UIApplication, @selector(openURL:), (IMP)&_logos_method$_ungrouped$UIApplication$openURL$, (IMP*)&_logos_orig$_ungrouped$UIApplication$openURL$);} }
#line 182 "Tweak.x"
