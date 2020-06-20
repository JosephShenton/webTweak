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

  // Install
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

%hook LSApplicationWorkspace
  
  - (id)URLOverrideForNewsURL:(id)arg1 {
    NSLog(@"[WebTweak] URLOverrideForNewsURL");

    return %orig;
  }

  - (id) URLOverrideForURL:(NSURL*)url {
    NSLog(@"[WebTweak] URLOverrideForURL %@", url);

    if ([url.scheme isEqualToString:@"webtweak"]) {
      NSLog(@"[WebTweak] WebTweak link, installing..");

      if ([url.path isEqualToString:@"/"] || [url.path isEqualToString:@""]) {
        // Empty so alert
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

    return %orig;
  }

  - (id) applicationsAvailableForOpeningURL:(id)arg1 {
    NSLog(@"[WebTweak] applicationsAvailableForOpeningURL");
    return %orig([self URLOverrideForURL:arg1]);
  }

  - (bool) openURL:(id)arg1 {
    NSLog(@"[WebTweak] openURL");
    return %orig([self URLOverrideForURL:arg1]);
  }

  - (bool) openURL:(id)arg1 withOptions:(id)arg2 {
    NSLog(@"[WebTweak] openURL:withOptions");
    return %orig([self URLOverrideForURL:arg1], arg2);
  }

  - (bool) openURL:(id)arg1 withOptions:(id)arg2 error:(id*)arg3 {
    NSLog(@"[WebTweak] openURL:withOptions:error");
    return %orig([self URLOverrideForURL:arg1], arg2, arg3);
  }

  // Safari

  - (void) _sf_openURL:(id)arg1 inApplication:(id)arg2 withOptions:(id)arg3 completionHandler:(id)arg4 {
    NSLog(@"[WebTweak] _sf_openURL:inApplication");
    %orig([self URLOverrideForURL:arg1], arg2, arg3, arg4);
  }

  - (void) _sf_openURL:(id)arg1 withOptions:(id)arg2 completionHandler:(id)arg3 {
    NSLog(@"[WebTweak] _sf_openURL:withOptions");
    %orig([self URLOverrideForURL:arg1], arg2, arg3);
  }

%end

%hook UIApplication
  
-(BOOL)openURL:(id)arg1 {
  if ([arg1 isKindOfClass:[NSString class]] || [arg1 isKindOfClass:[NSURL class]]) { // Argument 1 is a String or URL, this is what we want.
    if ([arg1 isKindOfClass:[NSString class]]) { // Argument 1 is a String, treat as such.
      NSString *url = arg1;
      if([url hasPrefix:@"webtweak://"]) { // Bingo, this means we are on the right track.
        url = [url stringByReplacingOccurrencesOfString:@"webtweak://" withString:@""];

        // Download
        const char *debChar = [url UTF8String];
          
        installTweak((char *)debChar);

        return YES;
      } else {
        return %orig;
      }

    } else if ([arg1 isKindOfClass:[NSURL class]]) { // Argument 1 is a String, treat as such.

      NSString *url = (NSString*)arg1;

      if([url hasPrefix:@"webtweak://"]) { // Bingo, this means we are on the right track.
        url = [url stringByReplacingOccurrencesOfString:@"webtweak://" withString:@""];

        // Download
        const char *debChar = [url UTF8String];
          
        installTweak((char *)debChar);
        
        return YES;
      } else {
        return %orig;
      }
    }
  }
  return NO;
}

%end