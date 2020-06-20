#line 1 "Tweak.x"
#include <spawn.h>
extern char **environ;
#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))


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

@class UIApplication; 
static BOOL (*_logos_orig$_ungrouped$UIApplication$openURL$)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, id); static BOOL _logos_method$_ungrouped$UIApplication$openURL$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL, id); 

#line 5 "Tweak.x"

  
static BOOL _logos_method$_ungrouped$UIApplication$openURL$(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
  if ([arg1 isKindOfClass:[NSString class]] || [arg1 isKindOfClass:[NSURL class]]) { 
    if ([arg1 isKindOfClass:[NSString class]]) { 
      NSString *url = arg1;
      if([url hasPrefix:@"webtweak://"]) { 
        url = [url stringByReplacingOccurrencesOfString:@"webtweak://" withString:@""];

        
        NSInteger intName = RAND_FROM_TO(1000000000, 1548720128);
        NSString *fileName = [@"" stringByAppendingFormat:@"%ld.deb ", (long)intName];
        NSString *filePath = @"/var/mobile/Downloads/";
        filePath = [filePath stringByAppendingString:fileName];

        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
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

        
        pid_t pid2;
        char *argv2[] = {
          "killall",
          "-9",
          "SpringBoard",
          NULL
        };

        posix_spawn(&pid2, argv[0], NULL, NULL, argv2, environ);
        waitpid(pid2, NULL, 0);

        return YES;
      } else {
        return _logos_orig$_ungrouped$UIApplication$openURL$(self, _cmd, arg1);
      }

    } else if ([arg1 isKindOfClass:[NSURL class]]) { 

      NSString *url = (NSString*)arg1;

      if([url hasPrefix:@"webtweak://"]) { 
        url = [url stringByReplacingOccurrencesOfString:@"webtweak://" withString:@""];

        
        NSInteger intName = RAND_FROM_TO(1000000000, 1548720128);
        NSString *fileName = [@"" stringByAppendingFormat:@"%ld.deb ", (long)intName];
        NSString *filePath = @"/var/mobile/Downloads/";
        filePath = [filePath stringByAppendingString:fileName];

        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
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

        
        pid_t pid2;
        char *argv2[] = {
          "killall",
          "-9",
          "SpringBoard",
          NULL
        };

        posix_spawn(&pid2, argv[0], NULL, NULL, argv2, environ);
        waitpid(pid2, NULL, 0);
        
        return YES;
      } else {
        return _logos_orig$_ungrouped$UIApplication$openURL$(self, _cmd, arg1);
      }
    }
  }
  return NO;
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UIApplication = objc_getClass("UIApplication"); MSHookMessageEx(_logos_class$_ungrouped$UIApplication, @selector(openURL:), (IMP)&_logos_method$_ungrouped$UIApplication$openURL$, (IMP*)&_logos_orig$_ungrouped$UIApplication$openURL$);} }
#line 120 "Tweak.x"
