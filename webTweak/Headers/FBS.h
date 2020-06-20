@interface FBSOpenApplicationOptions
@property (nonatomic, copy) NSDictionary *dictionary;
@end

@interface FBSProcessHandle : NSObject
@property (nonatomic, readonly, copy) NSString *bundleIdentifier;
@end

@interface BSAuditToken
@property (nonatomic, copy) NSString *bundleID;
@end

@interface LSAppLink
@property (copy) NSURL *URL;
@end