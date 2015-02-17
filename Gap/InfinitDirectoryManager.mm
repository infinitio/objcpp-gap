//
//  InfinitDirectoryManager.m
//  Gap
//
//  Created by Christopher Crone on 24/01/15.
//
//

#import "InfinitDirectoryManager.h"

#undef check
#import <elle/log.hh>

ELLE_LOG_COMPONENT("Gap-ObjC++.DirectoryManager");

static InfinitDirectoryManager* _instance = nil;

@implementation InfinitDirectoryManager

- (id)init
{
  NSCAssert(_instance == nil, @"Use the sharedInstance");
  if (self = [super init])
  {
  }
  return self;
}

+ (instancetype)sharedInstance
{
  if (_instance == nil)
    _instance = [[InfinitDirectoryManager alloc] init];
  return _instance;
}

#pragma mark - Transaction

- (NSString*)downloadDirectoryForTransaction:(InfinitTransaction*)transaction
{
  NSString* res = [self.download_directory stringByAppendingPathComponent:transaction.meta_id];
  if (![[NSFileManager defaultManager] fileExistsAtPath:res])
  {
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:res
                              withIntermediateDirectories:NO
                                               attributes:nil
                                                    error:&error];
    if (error)
    {
      ELLE_ERR("%s: unable to create transaction download folder: %s",
               self.description.UTF8String, error.description.UTF8String);
      return nil;
    }
  }
  return res;
}

#pragma mark - Directory Handling

- (NSString*)avatar_cache_directory
{
  NSString* cache_dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                            NSUserDomainMask,
                                                            YES).firstObject;
  NSString* avatar_dir = [cache_dir stringByAppendingPathComponent:@"avatar_cache"];
  if (![[NSFileManager defaultManager] fileExistsAtPath:avatar_dir isDirectory:NULL])
  {
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:avatar_dir
                              withIntermediateDirectories:YES
                                               attributes:@{NSURLIsExcludedFromBackupKey: @YES}
                                                    error:&error];
    if (error)
    {
      ELLE_ERR("%s: unable to create avatar cache folder: %s",
               self.description.UTF8String, error.description.UTF8String);
      return nil;
    }
  }
  return avatar_dir;
}

- (NSString*)download_directory
{
  NSString* doc_dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                          NSUserDomainMask,
                                                          YES).firstObject;
  NSString* res = [doc_dir stringByAppendingPathComponent:@"Downloads"];
  if (![[NSFileManager defaultManager] fileExistsAtPath:res])
  {
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:res
                              withIntermediateDirectories:NO
                                               attributes:@{NSURLIsExcludedFromBackupKey: @NO}
                                                    error:&error];
    if (error)
    {
      ELLE_ERR("%s: unable to create download folder: %s",
               self.description.UTF8String, error.description.UTF8String);
      return nil;
    }
  }
  return res;
}

- (NSString*)log_directory
{
  NSString* res = [self.non_persistent_directory stringByAppendingPathComponent:@"logs"];
  if (![[NSFileManager defaultManager] fileExistsAtPath:res])
  {
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:res
                              withIntermediateDirectories:YES
                                               attributes:@{NSURLIsExcludedFromBackupKey: @YES}
                                                    error:&error];
    if (error)
    {
      ELLE_ERR("%s: unable to create log folder: %s",
               self.description.UTF8String, error.description.UTF8String);
      return nil;
    }
  }
  return res;
}

- (NSString*)persistent_directory
{
  NSString* app_support_dir = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
                                                                  NSUserDomainMask,
                                                                  YES).firstObject;
  NSString* res = [app_support_dir stringByAppendingPathComponent:@"persistent"];
  if (![[NSFileManager defaultManager] fileExistsAtPath:res])
  {
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:res
                              withIntermediateDirectories:YES
                                               attributes:@{NSURLIsExcludedFromBackupKey: @NO}
                                                    error:&error];
    if (error)
    {
      ELLE_ERR("%s: unable to create persistent folder: %s",
               self.description.UTF8String, error.description.UTF8String);
      return nil;
    }
  }
  return res;
}

- (NSString*)non_persistent_directory
{
  NSString* app_support_dir = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
                                                                  NSUserDomainMask,
                                                                  YES).firstObject;
  NSString* res = [app_support_dir stringByAppendingPathComponent:@"non-persistent"];
  if (![[NSFileManager defaultManager] fileExistsAtPath:res])
  {
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:res
                              withIntermediateDirectories:NO
                                               attributes:@{NSURLIsExcludedFromBackupKey: @YES}
                                                    error:&error];
    if (error)
    {
      ELLE_ERR("%s: unable to create non-persistent folder: %s",
               self.description.UTF8String, error.description.UTF8String);
      return nil;
    }
  }
  return res;
}

- (NSString*)temporary_files_directory
{
  NSString* res = [NSTemporaryDirectory() stringByAppendingPathComponent:@"managed_files"];
  if (![[NSFileManager defaultManager] fileExistsAtPath:res])
  {
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:res
                              withIntermediateDirectories:NO
                                               attributes:@{NSURLIsExcludedFromBackupKey: @YES}
                                                    error:&error];
    if (error)
    {
      ELLE_ERR("%s: unable to create temporary managed files folder: %s",
               self.description.UTF8String, error.description.UTF8String);
      return nil;
    }
  }
  return res;
}

- (NSString*)thumbnail_cache_directory
{
  NSString* cache_dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                            NSUserDomainMask,
                                                            YES).firstObject;
  NSString* thumbnail_dir = [cache_dir stringByAppendingPathComponent:@"thumbnail_cache"];
  if (![[NSFileManager defaultManager] fileExistsAtPath:thumbnail_dir isDirectory:NULL])
  {
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:thumbnail_dir
                              withIntermediateDirectories:YES
                                               attributes:@{NSURLIsExcludedFromBackupKey: @YES}
                                                    error:&error];
    if (error)
    {
      ELLE_ERR("%s: unable to create thumbnail cache folder: %s",
               self.description.UTF8String, error.description.UTF8String);
      return nil;
    }
  }
  return thumbnail_dir;
}

#pragma mark - Disk Space

- (uint64_t)free_space
{
  uint64_t res = 0;
  __autoreleasing NSError* error = nil;
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSDictionary* dict =
    [[NSFileManager defaultManager] attributesOfFileSystemForPath:paths.lastObject error: &error];
  if (dict)
  {
    NSNumber* free_space_in_bytes = [dict objectForKey:NSFileSystemFreeSize];
    res = free_space_in_bytes.unsignedLongLongValue;
  }
  else
  {
    NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld",
          error.domain, (long)error.code);
  }
  return res;
}

@end
