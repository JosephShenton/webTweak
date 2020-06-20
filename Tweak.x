%hook UIApplication
	
	-(BOOL)openURL:(id)arg1 {

		if ([arg1 isKindOfClass:[NSString class]] || [arg1 isKindOfClass:[NSURL class]]) { // Argument 1 is a String or URL, this is what we want.
			
			if ([arg1 isKindOfClass:[NSString class]]) { // Argument 1 is a String, treat as such.

				if([arg1 hasPrefix:@"webtweak://"]) { // Bingo, this means we are on the right track.
				    
				} else {
					%orig;
				}

			} else if ([arg1 isKindOfClass:[NSURL class]]) { // Argument 1 is a String, treat as such.

				NSString *url = arg1.absoluteString;

				if([url hasPrefix:@"webtweak://"]) { // Bingo, this means we are on the right track.
				    
				} else {
					%orig;
				}

			}

		}

	}

%end