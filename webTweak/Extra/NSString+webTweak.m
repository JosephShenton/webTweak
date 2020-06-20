#import "NSString+webTweak.h"

@implementation NSString (WebTweak)

- (NSString*) encodeQueryPercentEscapes {
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?&=;+!@#$()',*"), kCFStringEncodingUTF8));
}

- (NSString*) decodeQueryPercentEscapes {
	NSString *newString = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
	return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)newString, CFSTR("")));
}

- (NSDictionary*) queryDictionary {
	//https://stackoverflow.com/questions/46603220/how-to-convert-url-query-to-dictionary-in-swift
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
	NSString *decoded = [self decodeQueryPercentEscapes];

	for (NSString *pair in [decoded componentsSeparatedByString:@"&"]) {
		NSArray *components = [pair componentsSeparatedByString:@"="];

		NSString *key = [components objectAtIndex:0];
		NSString *value = [components objectAtIndex:1];

		[dictionary setObject:value forKey:key];
	}
	return dictionary;
}

@end