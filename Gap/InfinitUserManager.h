//
//  InfinitUserManager.h
//  Infinit
//
//  Created by Christopher Crone on 31/10/14.
//  Copyright (c) 2014 Christopher Crone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InfinitUser.h"

#define INFINIT_NEW_USER_NOTIFICATION     @"INFINIT_NEW_USER_NOTIFICATION"
#define INFINIT_USER_STATUS_NOTIFICATION  @"INFINIT_USER_STATUS_NOTIFICATION"
#define INFINIT_USER_DELETED_NOTIFICATION @"INFINIT_USER_DELETED_NOTIFICATION"

@interface InfinitUserManager : NSObject

+ (instancetype)sharedInstance;

/** User with corresponding ID.
 @param id_
  User ID.
 @return User with corresponding ID.
 */
- (InfinitUser*)userWithId:(NSNumber*)id_;

/** Asynchronously fetch user with corresponding handle.
 When the result has been fetched, the selector of the object is called with a user object or nil
 if none was found.
 @param handle
  User's handle.
 @param selector
  Function to call when complete.
 @param object
  Calling object.
 */
- (void)userWithHandle:(NSString*)handle
       performSelector:(SEL)selector
              onObject:(id)object;

#pragma mark - State Manager Callbacks
- (void)newUser:(InfinitUser*)user;
- (void)userWithId:(NSNumber*)id_
     statusUpdated:(BOOL)status;
- (void)userDeletedWithId:(NSNumber*)id_;

@end
