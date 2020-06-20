#include <spawn.h>
extern char **environ;
#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))

%hook UIApplication
	
	-(BOOL)openURL:(id)arg1 {

		if ([arg1 isKindOfClass:[NSString class]] || [arg1 isKindOfClass:[NSURL class]]) { // Argument 1 is a String or URL, this is what we want.
			
			if ([arg1 isKindOfClass:[NSString class]]) { // Argument 1 is a String, treat as such.

				NSString *url = arg1;

				if([url hasPrefix:@"webtweak://"]) { // Bingo, this means we are on the right track.
				    url = [url stringByReplacingOccurrencesOfString:@"webtweak://" withString:@""];

				    // Download
				    NSInteger intName = RAND_FROM_TO(1000000000, 1548720128);
				    NSString *fileName = [@"" stringByAppendingFormat:@"%ld.deb", (long)intName];
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

					// Respring
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
					return %orig;
				}

			} else if ([arg1 isKindOfClass:[NSURL class]]) { // Argument 1 is a String, treat as such.

				NSString *url = (NSString*)arg1;

				if([url hasPrefix:@"webtweak://"]) { // Bingo, this means we are on the right track.
				    url = [url stringByReplacingOccurrencesOfString:@"webtweak://" withString:@""];

				    // Download
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

					// Respring
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
					return %orig;
				}

			}

		}
		return %orig;
	}

%end