//
//  InfinitDirectoryManager.h
//  Gap
//
//  Created by Christopher Crone on 24/01/15.
//
//

#import <Foundation/Foundation.h>

@interface InfinitDirectoryManager : NSObject

@property (nonatomic, readonly) NSString* avatar_cache_directory;
@property (nonatomic, readonly) NSString* download_directory;
@property (nonatomic, readonly) NSString* log_directory;
@property (nonatomic, readonly) NSString* persistent_directory;
@property (nonatomic, readonly) NSString* non_persistent_directory;
@property (nonatomic, readonly) NSString* temporary_files_directory;

+ (instancetype)sharedInstance;

@end
