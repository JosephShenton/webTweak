// https://github.com/hbang/libcephei/blob/master/NSString%2BHBAdditions.h
#import <Foundation/Foundation.h>

@interface NSString (WebTweak)
// Returns a string encoded for an HTTP query parameter.
- (NSString*) encodeQueryPercentEscapes;

// Returns a string decoded from an HTTP query parameter.
- (NSString*) decodeQueryPercentEscapes;

// Returns a dictionary containing the HTTP query parameters in the string.
- (NSDictionary*) queryDictionary;
@end